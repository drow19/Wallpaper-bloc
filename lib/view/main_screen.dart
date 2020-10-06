import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocwallpaper/bloc/main_bloc/main_screen_bloc.dart';
import 'package:flutterblocwallpaper/bloc/main_bloc/main_screen_event.dart';
import 'package:flutterblocwallpaper/bloc/main_bloc/main_screen_state.dart';
import 'package:flutterblocwallpaper/data/model/category.dart';
import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:flutterblocwallpaper/src/widget.dart';
import 'package:flutterblocwallpaper/view/detail_screen.dart';
import 'package:flutterblocwallpaper/view/search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainBloc _bloc;
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = new TextEditingController();
  List<Category> _category = new List<Category>();

  int _page = 30;

  _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _page = _page + 30;
      print(_page);
      _bloc.add(OnScrollPage(page: '$_page'));
    }
  }

  @override
  void initState() {
    super.initState();
    _category = getCategory();
    _bloc = BlocProvider.of<MainBloc>(context);
    _bloc.add(FetchData());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: TitleName(context),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: 6),
            height: 80,
            child: ListView.builder(
                itemCount: _category.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryName: _category[index].id,
                    img: _category[index].img,
                  );
                }),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: "search wallpapers", border: InputBorder.none),
                )),
                InkWell(
                    onTap: () {
                      if (_searchController.text != "") {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(
                                query: _searchController.text,
                              ),
                            )).then((value) {
                          _searchController.clear();
                        });
                      }
                    },
                    child: Container(child: Icon(Icons.search)))
              ],
            ),
          ),
          BlocBuilder<MainBloc, MainScreenState>(
              // ignore: missing_return
              builder: (ctx, state) {
            if (state is IsLoadingState) {
              return isLoading(context);
            } else if (state is IsLoadedState) {
              return buildListImage(state.list);
            } else if (state is ErrorState) {
              return isError(state.message);
            }
          })
        ],
      ),
    );
  }

  Widget buildListImage(List<ImageModel> _list) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: GridView.builder(
            controller: _scrollController,
            itemCount: _list.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => DetailScreen(
                              imgUrl: _list[index].srcModel.portrait)));
                },
                child: Hero(
                  tag: _list[index].srcModel.portrait,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: _list[index].srcModel.portrait,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String categoryName, img;

  CategoryTile({this.categoryName, this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchScreen(query: categoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8, top: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: img,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                categoryName,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
