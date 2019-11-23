import 'dart:convert';

import 'package:sayit/model/Level.dart';

class UnlockedLevelsDao {
  static const String defaultJson = '[{"levelNumber":1,"words":["cat","dog"],"unlocked":true},{"levelNumber":2,"words":["How","Why"],"unlocked":false},{"levelNumber":3,"words":["There","Their"],"unlocked":false},{"levelNumber":4,"words":["Through","Thought"],"unlocked":false}]';
  static List<Level> levelFromJson(String str) => List<Level>.from(json.decode(str).map((x) => Level.fromJson(x)));

  String levelToJson(List<Level> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  static List<Level> getLevelList() => levelFromJson(defaultJson);
}