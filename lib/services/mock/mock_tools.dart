import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:twitter_clone/models/model_base.dart';

class MockTools {

  MockTools._();

  static Future<Model?> jsonToModel<Model extends ModelBase>(
      String jsonPath, Function(Map<String, dynamic> data) fromMap) async {
    var jsonObject = await getJsonObject(jsonPath);

    return fromMap(jsonObject);
  }

  static Future<List<Model>?> jsonToModelList<Model extends ModelBase>(
      String jsonPath, Function(Map<String, dynamic> data) fromMap) async {
    var jsonObject = await getJsonObject(jsonPath);

    var listObjects = jsonObject.map((itemJson) => fromMap(itemJson));

    return List<Model>.from(listObjects);
  }

  static Future<dynamic> getJsonObject(String jsonPath) async {
    var jsonString = await rootBundle.loadString(jsonPath);
    return json.decode(jsonString);
  }

  static Future<void> simulateRequestDelay() async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  static Future<void> simulateQuickRequestDelay() async {
    await Future.delayed(Duration(milliseconds: 130));
  }
}
