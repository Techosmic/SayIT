import 'dart:convert';

import 'package:sayit/model/Level.dart';
import 'package:http/http.dart' as http;

const url = "https://sayitapi.azurewebsites.net/api";

class LevelsDAO {
  static List<Level> levelFromJson(String str) => List<Level>.from(json.decode(str).map((x) => Level.fromJson(x)));

  static String levelToJson(List<Level> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  static Future<List<Level>> getLevelsListAsync() async {
    final response = await http.get('$url/level');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return levelFromJson(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to fetch levels');
    }
  }
}