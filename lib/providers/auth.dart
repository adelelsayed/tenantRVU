import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:tenant_review/http/http_interface.dart';

class Auth with ChangeNotifier {
  String userName = "";
  String passWord = "";
  Map<String, String> _token = {};
  late DateTime _expiryDate;
  late String _userId;
  late Timer _authTimer;
  Map<String, String> authErrors = {};
  bool _isAuth = false;
  String registerationState = "Logon";

  bool get isAuth {
    return _isAuth;
  }

  Future<void> getRegisterationState() async {}

  Map<String, String> get token {
    return _token;
  }

  void set token(tokenMap) {
    _token = tokenMap;
  }

  Future<bool> register(String pUserName, String pPassWord, String pEmail,
      String pPhoneNumber) async {
    notifyListeners();
    return true;
  }

  Future<bool> authenticate(String pUserName, String pPassWord) async {
    Uri loginURL = Uri.parse("https://tenantrvu.com/api/token/");
    TRVUHttp HttpRequest =
        TRVUHttp(loginURL, {"username": pUserName, "password": pPassWord},
            (responseObj) {
      if (responseObj.statusCode == 200) {
        Map<String, dynamic> tokenData =
            Map<String, dynamic>.from(json.decode(responseObj.body));
        token = Map<String, String>.from({"token": tokenData["access"]});
      } else {}
    });
    HttpRequest.post();

    notifyListeners();
    return true;
  }
}
