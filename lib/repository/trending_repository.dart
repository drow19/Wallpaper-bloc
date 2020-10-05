import 'dart:convert';
import 'package:flutterwallpaper/helper/base_url.dart';
import 'package:flutterwallpaper/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class TrendingRepo {
  Future<List<WallpaperModel>> getData(String max) async {
    String _url = baseUrl + max;

    final response = await http.get(_url, headers: {"Authorization": api_key});

    print(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<WallpaperModel> jsonParse(final response) {
    final json = jsonDecode(response);
    final data = json['photos'];

    print("response data : $data");

    return new List<WallpaperModel>.from(
        data.map((e) => WallpaperModel.fromJson(e)));
  }
}
