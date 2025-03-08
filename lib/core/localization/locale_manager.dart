import "package:flutter/material.dart";
import "dart:convert";

import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";

// convert - json dosyalarını işlemek için eklendi.

class LocaleManager extends ChangeNotifier{
  Locale _currentLocale = const Locale('tr');
  Map<String, String> _localizedStrings = {}; // tüm çevirileri tutmak için

  Locale get currentLocale => _currentLocale;

  String translate(String key){
    return _localizedStrings[key] ?? key;
  }

  LocaleManager(){
    _loadLocale();
  }
  Future<void> changeLocale(Locale locale) async{
    _currentLocale = locale;
    await _saveLocale(locale.languageCode);
    await _loadLanguage();
    notifyListeners();
  }
  Future<void>_loadLanguage() async{
    String jsonString = await rootBundle.loadString('assets/lang/${_currentLocale.languageCode}.json');

    Map<String,dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key,value) => MapEntry(key, value.toString()));


  }
  Future<void> _saveLocale(String langCode) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', langCode);
  }

  Future<void> _loadLocale() async{
    final prefs = await SharedPreferences.getInstance();
    final savedLangCode = prefs.getString('langCode') ?? 'tr'; // tr - default

    _currentLocale = Locale(savedLangCode);

    await _loadLanguage();
    notifyListeners();
  }
}

