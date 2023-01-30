import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:note_app_pro/utils/helper.dart';
import 'package:provider/provider.dart';
import '../../routing/navigations.dart';
import '../../routing/router.dart';
import '../data/local/sharedController.dart';
import '../data/shared/Repository/authRepository.dart';
import '../data/shared/apiHelper.dart';
import '../models/apiResponce.dart';
import '../models/studentModel.dart';
import 'noteProvider.dart';

class AuthProvider extends ChangeNotifier with ApiHelper {
  bool isLoading = false;

//--------------------------------------login-----------------------------------
  Future<dynamic> login(
    String email,
    String password,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      dynamic dataResponse = await AuthRepository()
          .loginRepository(email: email, password: password);
      Student student = Student.fromJson(dataResponse['object']);
      SharedPrefController().saveData(student: student);
      if (dataResponse["status"] == true) {
        isLoading = false;
        notifyListeners();
        Helpers.showSnackBar(
            message: dataResponse["message"], status: dataResponse["status"]);
        ServiceNavigation.serviceNavi
            .pushNamedReplacement(RouteGenerator.homePage);
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      debugPrint('This is in Provider${error.toString()}');
      handleError(error);
    }
    notifyListeners();
  }

//-------------------------------------register---------------------------------

  Future<void> register(
      {required String fullName,
      required String email,
      required String password,
      required String gender}) async {
    try {
      isLoading = true;
      notifyListeners();
      debugPrint("This is in provider before response functions");
      Response dataResponse = await AuthRepository().register(
          fullName: fullName, email: email, password: password, gender: gender);
      ApiResponseModel responseModel =
          ApiResponseModel.fromJson(jsonDecode(dataResponse.body));
      debugPrint("This is The Response in Provider \n ${dataResponse.body}");
      if (responseModel.status == true) {
        isLoading = false;
        notifyListeners();
        Helpers.showSnackBar(
            message: responseModel.message, status: responseModel.status);
        ServiceNavigation.serviceNavi
            .pushNamedWidget(RouteGenerator.loginPage);
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      handleError(error);
      notifyListeners();
    }
  }

//-----------------------------------logout-------------------------------------
  Future<void> logout() async {
    try {
      ApiResponseModel responseModel =
          ApiResponseModel.fromJson(await AuthRepository().logoutRepository());
      if (responseModel.status) {
        SharedPrefController().logout();
        Provider.of<NoteProvider>(
                ServiceNavigation.serviceNavi.navKey.currentContext!,
                listen: false)
            .clearTask();
        Helpers.showSnackBar(
            message: responseModel.message, status: responseModel.status);
        ServiceNavigation.serviceNavi
            .pushNamedAndRemoveUtils(RouteGenerator.loginPage);
      }
    } catch (error) {
      handleError(error);
    }
  }

//-------------------------------unauthenticatedLogout--------------------------

  Future<void> unauthenticatedLogout() async {

        SharedPrefController().logout();
        Provider.of<NoteProvider>(
            ServiceNavigation.serviceNavi.navKey.currentContext!,
            listen: false)
            .clearTask();
        Helpers.showSnackBar(
            message: "Logout Successful", status: true);
        ServiceNavigation.serviceNavi
            .pushNamedAndRemoveUtils(RouteGenerator.loginPage);
  }


//-----------------------------------forgetPassword-----------------------------

  Future<void> forgetPassword(String email) async {

    try {
      isLoading = true;
      notifyListeners();
      dynamic dataResponse = await AuthRepository().forgetPasswordRepository(email);
      debugPrint("$dataResponse");
      ApiResponseModel responseModel = ApiResponseModel.fromJson(
          await AuthRepository().forgetPasswordRepository(email));
      debugPrint("This is in provider in forgetPassword (massage) = \n ${responseModel.message}");
      if (responseModel.status) {
        isLoading = false;
        notifyListeners();
        debugPrint("This is isLoading in if $isLoading");

        Helpers.showSnackBar(
            message: dataResponse["code"].toString(),
            status: responseModel.status);
        ServiceNavigation.serviceNavi
            .pushNamedWidget(RouteGenerator.resetPassword);
      }

    } catch (error) {
      isLoading = false;
      notifyListeners();
      debugPrint("This is isLoading in catche $isLoading");

      handleError(error);
    }
  }

  Future<dynamic> resetPassword(
      String email, String code, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      ApiResponseModel responseModel = ApiResponseModel.fromJson(
          await AuthRepository().resetPasswordRepository(
              email: email, code: code, password: password));
      if (responseModel.status) {
        isLoading = false;
        notifyListeners();
        Helpers.showSnackBar(
            message: responseModel.message, status: responseModel.status);
        ServiceNavigation.serviceNavi
            .pushNamedWidget(RouteGenerator.loginPage);
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      handleError(error);
    }
  }
}
