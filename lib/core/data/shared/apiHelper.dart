import 'package:flutter/material.dart';

import '../../../utils/helper.dart';
import 'handelException.dart';

mixin ApiHelper{
  void handleError(error) {
    debugPrint("This is inside handel error");
    if (error is BadRequestException) {
      debugPrint("This is BadRequestException error");
      Helpers.showSnackBar(
          message: error.message.toString(), status: false);
    } else if (error is FetchDataException) {
      debugPrint("This is FetchDataException error");
      Helpers.showSnackBar(
          message: error.message.toString(), status: false);
    } else if (error is ApiNotResponseException) {
      debugPrint("This is ApiNotResponseException error");
      Helpers.showSnackBar(
          message: error.message.toString(), status: false);
    } else {
      debugPrint("This is another error");
      Helpers.showSnackBar(
          message: "something went wrong ", status: false);
    }
  }}
