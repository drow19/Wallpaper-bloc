import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterwallpaper/Widget/Widget.dart';
import 'package:flutterwallpaper/model/wallpaper_model.dart';
import 'package:flutterwallpaper/repository/category_repository.dart';
import 'package:flutterwallpaper/search_pages.dart';
import 'package:flutterwallpaper/view_photo_pages.dart';

class CategoryPages extends StatefulWidget {
  final String category;

  CategoryPages({@required this.category});

  @override
  _CategoryPagesState createState() => _CategoryPagesState();
}

class _CategoryPagesState extends State<CategoryPages> {
  List<WallpaperModel> _list = new List<WallpaperModel>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _searchController = new TextEditingController();

  ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  int _page = 30;

  Future<String> getData() async {
    print(_isLoading);

    await CategoryRepo()
        .getData(widget.category, _page.toString())
        .then((value) {
      setState(() {
        _isLoading = true;
        _list = value;
      });
    });
    print(_isLoading);
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
    // TODO: implement initState
    super.initState();
    this.getData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
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
            CategoryName(context, widget.category),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
          controller: _scrollController,
          itemCount: _list.length,
          cacheExtent: 9999,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                MaterialPageRoute(
                    builder: (context) =>
                        ViewPages(imgUrl: _list[index].srcModel.portrait));
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
    );
  }
}
