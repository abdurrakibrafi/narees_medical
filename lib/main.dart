// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/controller/language_controller.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/message.dart';
import 'package:restaurent_discount_app/view/splash_view/splash_view.dart';
import 'common widget/language widget/dep.dart' as dep;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Get.put(LanguageController()).initStorage();

  Map<String, Map<String, String>> languages = await dep.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MyApp(languages: languages),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          translations: Messages(languages: languages),
          fallbackLocale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          home: SplashView(),
          //  home: BottomNavigation(),
        );
      },
    );
  }
}
