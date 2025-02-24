import 'dart:convert';

import 'package:ecommerce_app/features/auth/data/model/response/app_user.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppPreferences {
  Future<void> saveUser(AppUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<AppUser?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedJson = await prefs.getString('user');
    if (encodedJson == null) return null;
    return AppUser.fromJson(jsonDecode(encodedJson));
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
