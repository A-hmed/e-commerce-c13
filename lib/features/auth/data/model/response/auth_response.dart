import 'app_user.dart';

class AuthResponse {
  String? message;
  AppUser? user;
  String? token;

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }
}
