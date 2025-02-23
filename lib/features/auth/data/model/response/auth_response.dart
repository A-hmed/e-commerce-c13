import 'app_user.dart';

class AuthResponse {
  AuthResponse({
    this.message,
    this.user,
    this.token,
  });

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? AppUser.fromJson(json['user']) : null;
    token = json['token'];
  }

  String? message;
  AppUser? user;
  String? token;
}
