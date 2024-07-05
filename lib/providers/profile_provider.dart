import 'package:flutter/material.dart';

class Profile extends ChangeNotifier {
  String? _email = '';

  String? get email => _email;

  void setEmail(String? newEmail) {
    _email = newEmail;
    notifyListeners();
  }
}