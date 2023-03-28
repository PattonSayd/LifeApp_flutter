import 'package:flutter/material.dart';
import 'package:lifeapp/localization/languages/az.dart';

import 'languages/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['az'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'az':
        return LanguageAz();
      default:
        return LanguageAz();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}