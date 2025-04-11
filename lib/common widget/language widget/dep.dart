import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/controller/localization_controller.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/model/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_component.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in LanguageComponent.languages) {
    try {
      String jsonStringValues = await rootBundle
          .loadString('assets/language/${languageModel.languageCode}.json');
      Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
      Map<String, String> _json = {};

      mappedJson.forEach((key, value) {
        _json[key] = value.toString();
      });

      languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
          _json;
    } catch (e) {
      print('Error loading language file for ${languageModel.languageCode}: $e');
    }
  }

  return languages;
}
