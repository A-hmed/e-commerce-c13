import 'dart:convert';

import 'package:ecommerce_app/features/auth/data/model/response/app_user.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

@singleton
class SharedPreferencesHelper {
  Future saveUser(AppUser? user) async {
    if (user == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("app_user", jsonEncode(user.toJson()));
  }

  Future<AppUser?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedJson = prefs.getString("app_user");
    if (encodedJson == null) return null;
    return AppUser.fromJson(jsonDecode(encodedJson));
  }

  Future saveToken(String? token) async {
    if (token == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
