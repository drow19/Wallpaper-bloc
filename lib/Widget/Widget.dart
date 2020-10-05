import 'package:flutter/material.dart';
import 'package:flutterwallpaper/model/category_model.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CategoryName(BuildContext context, String title) {
  return RichText(
      text: TextSpan(
        text: title.capitalize(),
        style: GoogleFonts.averageSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black),
  ));
}

Widget TitleName(BuildContext context) {
  return RichText(
      text: TextSpan(
          text: "Wallpaper",
          style: GoogleFonts.droidSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          children: [
        TextSpan(
          text: "App",
          style: GoogleFonts.averageSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.blue),
        )
      ]));
}

List<CategoryModel> getCategory() {
  List<CategoryModel> categoryTile = new List<CategoryModel>();

  CategoryModel categoryModel = new CategoryModel();
  categoryModel.id = "Nature";
  categoryModel.img =
      "https://images.pexels.com/photos/775201/pexels-photo-775201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.id = "City";
  categoryModel.img =
      "https://images.pexels.com/photos/830891/pexels-photo-830891.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  categoryTile.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.id = "Graffiti";
  categoryModel.img =
      "https://images.pexels.com/photos/1570264/pexels-photo-1570264.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.id = "Urban";
  categoryModel.img =
      "https://images.pexels.com/photos/1236701/pexels-photo-1236701.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.id = "Animal";
  categoryModel.img =
      "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.id = "Fashion";
  categoryModel.img =
      "https://images.pexels.com/photos/322207/pexels-photo-322207.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.id = "Black & White";
  categoryModel.img =
      "https://images.pexels.com/photos/3780365/pexels-photo-3780365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  categoryTile.add(categoryModel);

  return categoryTile;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
