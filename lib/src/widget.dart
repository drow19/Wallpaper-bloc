import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget isLoading(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.5,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget isError(String message) {
  return Center(
    child: Text(
      message,
      style: TextStyle(
          fontSize: 14, color: Color(0xff000000), fontWeight: FontWeight.w500),
    ),
  );
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
