import 'dart:convert';

class ApiResponseModel{
  late String message;
  late bool status;

  ApiResponseModel({required this.message, required this.status});

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  status = json['status'] ?? false;
  }



}