import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocwallpaper/bloc/search_bloc/search_bloc.dart';
import 'package:flutterblocwallpaper/bloc/search_bloc/search_event.dart';
import 'package:flutterblocwallpaper/bloc/search_bloc/search_state.dart';
import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:flutterblocwallpaper/src/widget.dart';

class SearchScreen extends StatefulWidget {

  final query;
  SearchScreen({@required this.query});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = new TextEditingController();

  ScrollController _scrollController = ScrollController();

  SearchBloc _bloc;

  int _page = 30;

  _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _page = _page + 30;
      print(_page);
      _bloc.add(OnScrollEvent(page: '$_page', query: widget.query));
    }
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<SearchBloc>(context);
    _bloc.add(FetchData(query: widget.query));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                  size: 25,
                )),
            SizedBox(
              width: 16,
            ),
            /*CategoryName(context, widget.search),*/
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        setState(() {
                          _bloc.add(FetchData(query: _searchController.text));
                        });
                      }
                    },
                    child: Container(child: Icon(Icons.search)))
              ],
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
              // ignore: missing_return
              builder: (ctx, state){
                if(state is IsLoadingState){
                  return isLoading(context);
                }else if(state is IsLoadedState){
                  return buildListImage(state.list);
                }else if(state is ErrorState){
                  return isError(state.message);
                }
              })
        ],
      ),
    );
  }

  Widget buildListImage(List<ImageModel> _list){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
            controller: _scrollController,
            itemCount: _list.length,
            cacheExtent: 9999,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  /*MaterialPageRoute(
                      builder: (context) =>
                          ViewPages(imgUrl: _list[index].srcModel.portrait));*/
                },
                child: Hero(
                  tag: _list[index].srcModel.portrait,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.transparent),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        child: CachedNetworkImage(
                          imageUrl: _list[index].srcModel.portrait,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
