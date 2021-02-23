import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:twitter_clone/models/model_base.dart';

class JsonTools {
  static Future<Model> jsonToModel<Model extends ModelBase>(String jsonPath, Function(Map<String, dynamic> data) fromMap) async{
    var jsonObject = await _getJsonObject(jsonPath);

    return fromMap(jsonObject);
  }

  static Future<List<Model>> jsonToModelList<Model extends ModelBase>(String jsonPath, Function(Map<String, dynamic> data) fromMap) async {
    var jsonObject = await _getJsonObject(jsonPath);

    var listObjects = jsonObject.map((itemJson) => fromMap(itemJson));

    return List<Model>.from(listObjects);
  }

  static Future<dynamic> _getJsonObject(String jsonPath) async {
    var jsonString = await rootBundle.loadString(jsonPath);
    return json.decode(jsonString);
  }
}