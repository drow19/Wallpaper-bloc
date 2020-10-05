import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterwallpaper/Widget/Widget.dart';
import 'package:flutterwallpaper/category_pages.dart';
import 'package:flutterwallpaper/model/category_model.dart';
import 'package:flutterwallpaper/model/wallpaper_model.dart';
import 'package:flutterwallpaper/repository/trending_repository.dart';
import 'package:flutterwallpaper/search_pages.dart';
import 'package:flutterwallpaper/view_photo_pages.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  List<CategoryModel> _category = new List<CategoryModel>();

  List<WallpaperModel> _trending = new List<WallpaperModel>();

  ScrollController _scrollController = ScrollController();

  TextEditingController _searchController = new TextEditingController();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _page = 30;
  bool _isLoading = false;

  Future<String> getData() async {
    await TrendingRepo().getData(_page.toString()).then((value) {
      setState(() {
        _isLoading = true;
        _trending = value;
      });
    });
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _page = _page + 30;
      print(_page);
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    _category = getCategory();
    this.getData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                                builder: (context) => SearchPages(
                                      search: _searchController.text,
                                    )));
                      }
                    },
                    child: Container(child: Icon(Icons.search)))
              ],
            ),
          ),
          _isLoading == false ? _loading() : Flexible(child: _listData())
        ],
      ),
    );
  }

  Widget _loading() {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 3),
        child: CircularProgressIndicator());
  }

  Widget _listData() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GridView.builder(
          controller: _scrollController,
          cacheExtent: 9999,
          itemCount: _trending.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPages(
                            imgUrl: _trending[index].srcModel.portrait)));
              },
              child: Hero(
                tag: _trending[index].srcModel.portrait,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.transparent),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: CachedNetworkImage(
                        imageUrl: _trending[index].srcModel.portrait,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            );
          }),
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
                    CategoryPages(category: categoryName.toLowerCase())));
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
