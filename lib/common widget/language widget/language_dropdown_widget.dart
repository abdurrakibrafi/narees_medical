// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/language_component.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/controller/localization_controller.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final LocalizationController localizationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (controller) {
        return DropdownButtonHideUnderline(
          child: DropdownButton<LanguageItem>(
            value: LanguageItem(
              controller.languages[controller.selectedIndex].languageName,
              controller.languages[controller.selectedIndex].flag,
            ),
            items: controller.languages.map((language) {
              return DropdownMenuItem<LanguageItem>(
                value: LanguageItem(language.languageName, language.flag),
                child: Row(
                  children: [
                    Text(
                      language.flag,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 12),
                    Text(
                      language.languageName,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (selected) {
              int index = controller.languages.indexWhere(
                  (language) => language.languageName == selected!.name);
              Locale locale = Locale(controller.languages[index].languageCode,
                  controller.languages[index].countryCode);
              controller.setLanguage(locale);
              controller.setSelectIndex(index);
            },
            icon: Icon(Icons.arrow_drop_down, color: AppColors.mainColor),
            selectedItemBuilder: (BuildContext context) {
              return controller.languages.map((language) {
                return Row(
                  children: [
                    Text(
                      language.flag,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 8),
                    Text(
                      language.languageName,
                      style: TextStyle(color: AppColors.mainColor),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        );
      },
    );
  }
}

class LanguageItem {
  final String name;
  final String flag;

  LanguageItem(this.name, this.flag);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          flag == other.flag;

  @override
  int get hashCode => name.hashCode ^ flag.hashCode;
}
