import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/language%20widget/model/language_model.dart';

class LanguageComponent {
  static const String COUNTRY_CODE = "country_code";
  static const String LANGUAGE_CODE = "language_code";

  static List<LanguageModel> languages = [
    LanguageModel(
      countryCode: "US",
      languageCode: "en",
      languageName: "English".tr,
      flag: "🇺🇸",
    ),
    LanguageModel(
      countryCode: "PK",
      languageCode: "ur",
      languageName: "Urdu".tr,
      flag: "🇵🇰",
    ),
    LanguageModel(
      countryCode: "SA",
      languageCode: "ar",
      languageName: "Arabic".tr,
      flag: "🇸🇦",
    ),
  ];
}
