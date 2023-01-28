import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/studentModel.dart';
import 'dart:convert';

enum PrefKeys {id, full_name, email, gender, token, refresh_token ,isLoggedIn}

class SharedPrefController {
  final String user = "USER";
  SharedPrefController._();

  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isLoggedIn() {
    return sharedPreferences.getBool(PrefKeys.isLoggedIn.name) ?? false;
  }

  Future<bool> saveData(
      {required Student student}) async {
    String userJson = jsonEncode(student.toJson());
    await sharedPreferences.setBool(PrefKeys.isLoggedIn.name, true);
    return await sharedPreferences.setString(user, userJson);
  }



  saveColor1({required String color}) async {
    return await sharedPreferences.setString("Color1", color);
  }

  saveColor2({required String color}) async {
    return await sharedPreferences.setString("Color2", color);
  }

  getColor1() {
     return sharedPreferences.getString("Color1") ?? "0xFF0074E1";
  }

  getColor2() {
     return sharedPreferences.getString("Color2") ?? "0xFF6BF5DE";
  }

  Student getUser() {
    final student = jsonDecode(sharedPreferences.getString(user)!);
    return Student.fromJson(student) ;
  }

  Future<bool> logout()  {
    return sharedPreferences.clear();
  }

  // String get email{
  //   return _sharedPreferences.getString("email")??'';
  // }
  // String get token => _sharedPreferences.getString(PrefKeys.token.name) ?? '';
  // String get token => _sharedPreferences.getString(getUser().token) ?? '';
}
