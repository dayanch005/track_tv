import 'package:flutter/material.dart';

class AppPhoto extends ChangeNotifier {
  String _photoUrl = "";

  String get photoUrl => _photoUrl;

  void updatePhoto(String newUrl) {
    _photoUrl = newUrl;
    notifyListeners();
  }
}
