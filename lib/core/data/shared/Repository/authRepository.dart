import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../local/sharedController.dart';
import '../apiHelper.dart';
import '../apiEndPoint.dart';
import '../baseClient.dart';

class AuthRepository extends EndPoint with ApiHelper {

  Future<http.Response> register({required String fullName, required String email, required String password, required String gender}) async {
    Uri uri = Uri.parse(super.userRegister);
    http.Response response = await http.post(uri, body: {
      "full_name": fullName,
      "email": email,
      "password": password,
      "gender": gender,
    });
    return response;
  }


  Future<dynamic> loginRepository(
      {required String email, required String password}) async {
    debugPrint("This is email : $email");
    return await BaseClient.baseClient
        .post(super.userLogin, body: {"email": email, "password": password});
  }

  Future<dynamic> logoutRepository() async {
    debugPrint(SharedPrefController().getUser().token);

      return
          await BaseClient.baseClient.get(super.userLogOut, {
        HttpHeaders.authorizationHeader:
            'Bearer ${SharedPrefController().getUser().token}',
            "Accept": "application/json"
      });
  }

  Future<dynamic> forgetPasswordRepository(String email) async {
    return await BaseClient.baseClient.post(super.userForgetPassword, body: {"email": email});
  }

  Future<dynamic> resetPasswordRepository(
      {required String email,
      required String code,
      required String password}) async {
    var response = await BaseClient.baseClient.post(super.userResetPassword, body: {
      "email": email,
      "code": code,
      "password": password,
      "password_confirmation": password
    });
    return response;
  }
}
