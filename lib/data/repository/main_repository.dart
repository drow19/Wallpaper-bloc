import 'dart:convert';
import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:flutterblocwallpaper/helper/constant.dart';
import 'package:http/http.dart' as http;

class MainRepository {
  Future<List<ImageModel>> getData(String page) async {
    String _url = baseUrl + page;

    final response = await http.get(_url, headers: {'Authorization': api_key});

    if (response.statusCode == 200)
      return parseJson(response.body);
    else
      throw Exception();
  }

  List<ImageModel> parseJson(final response) {
    final json = jsonDecode(response);
    final data = json['photos'];

    return new List<ImageModel>.from(data.map((e) => ImageModel.fromJson(e)));
  }
}
