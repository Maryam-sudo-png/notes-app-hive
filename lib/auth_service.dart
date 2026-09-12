import 'package:hive_flutter/hive_flutter.dart';

class AuthService {
  static const String boxName = 'authBox';

  static Future<bool> hasAccount() async {
    final box = Hive.box(boxName);
    return box.containsKey('email');
  }

  static Future<void> register(String email, String password) async {
    final box = Hive.box(boxName);
    await box.put('email', email);
    await box.put('password', password);
  }

  static Future<bool> login(String email, String password) async {
    final box = Hive.box(boxName);
    return box.get('email') == email && box.get('password') == password;
  }
}