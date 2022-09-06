import 'package:flutter/material.dart';

class LanguageChangeProvider extends ChangeNotifier{
  Locale _currentLocale = new Locale("en");


  Locale get currentLocale => _currentLocale;

  void changeLanguage(String newLocale){
    this._currentLocale = new Locale(newLocale);
    notifyListeners();
  }

}