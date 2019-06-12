import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photo_share/models/User.dart';
import 'package:photo_share/utilities/stringConstants.dart';

class UserManager {
  Future<bool> isLoggedIn() async => await getToken().then((token) {
        return token != null;
      });

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    storage.delete(key: tokenKey);
  }

  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();
    String value = await storage.read(key: tokenKey);
    print("retrived token : $value");
    return value;
  }

  static Future<void> saveToken({token: String}) async {
    print("saved token : $token");
    final storage = FlutterSecureStorage();
    await storage.write(key: tokenKey, value: token);
  }

  static Future<void> saveUserSecure({User user}) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: userKey, value: user.toJson().toString());
  }

  static Future<User> getUserSecure(User user) async {
    final storage = FlutterSecureStorage();
    var user = await storage.read(key: userKey);
    var json = jsonDecode(user);
    return User.fromJson(json);
  }
}

var userManager = UserManager();
