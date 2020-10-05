import 'dart:convert';

class WallpaperModel {
  int id;
  String url;
  String photographer;
  String photographer_url;
  SrcModel srcModel;

  WallpaperModel(
      {this.id,
      this.url,
      this.photographer,
      this.photographer_url,
      this.srcModel});

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
        id: json['id'],
        url: json['url'],
        photographer: json['photographer'],
        photographer_url: json['photographer_url'],
        srcModel: SrcModel.fromJson(json['src']));
  }
}

class SrcModel {
  String original;
  String portrait;

  SrcModel({this.original, this.portrait});

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(original: json['original'], portrait: json['portrait']);
  }
}
