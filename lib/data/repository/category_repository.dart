import 'dart:convert';
import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:flutterblocwallpaper/helper/constant.dart';
import 'package:http/http.dart' as http;

class CategoryRepo {
  Future<List<ImageModel>> getData(String query, String page) async {
    String _url = categoryUrl + '$query&per_page=$page';

    print(_url);

    final response = await http.get(_url, headers: {'Authorization': api_key});

    if (response.statusCode == 200)
      return jsonParse(response.body);
    else
      throw Exception();
  }

  List<ImageModel> jsonParse(final response) {
    final json = jsonDecode(response);
    final data = json['photos'];

    return new List<ImageModel>.from(data.map((e) => ImageModel.fromJson(e)));
  }
}
