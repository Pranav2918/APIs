import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:searchwithapi/data/musicModel.dart';

import '../data/userModel.dart';

class AppServices {
  Future<List<Users>> getUsers() async {
    const baseUrl = "https://jsonplaceholder.typicode.com/users";
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Users> users = data.map((user) => Users.fromJson(user)).toList();
      return users;
    } else {
      throw Exception("Failed to fetch Users");
    }
  }

  Future<List<Results>> getMusics() async {
    const baseUrl =
        "https://itunes.apple.com/search?term=jack+johnson&limit=50";
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<dynamic> dataResults = data['results'];
      List<Results> results =
          dataResults.map((e) => Results.fromJson(e)).toList();
      return results;
    } else {
      throw Exception("Unable to fetch musics");
    }
  }
}
