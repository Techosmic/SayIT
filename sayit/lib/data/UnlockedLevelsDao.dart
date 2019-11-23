import 'dart:convert';

import 'package:sayit/model/Level.dart';

class UnlockedLevelsDao {
  static const String defaultJson = "[{\"levelNumber\":1},{\"levelNumber\":2},{\"levelNumber\":3},{\"levelNumber\":4}]";
  static List<Level> levelFromJson(String str) => List<Level>.from(json.decode(str).map((x) => Level.fromJson(x)));

  String levelToJson(List<Level> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  static List<Level> getLevelList() => levelFromJson(defaultJson);
}