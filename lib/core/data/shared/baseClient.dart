import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../routing/navigations.dart';
import '../../../utils/helper.dart';
import '../../provider/authProvider.dart';
import 'handelException.dart';

class BaseClient {
  BaseClient._();
  final contextKey = ServiceNavigation.serviceNavi.navKey.currentContext!;
  var provider = Provider.of<AuthProvider>(
      ServiceNavigation.serviceNavi.navKey.currentContext!,
      listen: false);

  int timeout = 30;
  static BaseClient baseClient = BaseClient._();

//------------------------------------get---------------------------------------
  Future<dynamic> get(String url, Map<String, String>? headers) async {
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: timeout));
      return _processingException(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotResponseException(
          'API not responded in time', url.toString());
    }
  }


//----------------------------------post----------------------------------------

  Future<dynamic> post(String url,
      {Map<String, String>? headers, required dynamic body}) async {

    try{
      http.Response response = await http
          .post(Uri.parse(url), headers: headers, body: body)
          .timeout(Duration(seconds: timeout));
      return _processingException(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotResponseException(
          'API not responded in time', url.toString());
    }
  }


//----------------------------------delete--------------------------------------
  Future<dynamic> delete(String url, Map<String, String> headers) async {
    Uri uri = Uri.parse(url);
    try{
      http.Response response = await http.delete(uri, headers: headers);
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return _processingException(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotResponseException(
          'API not responded in time', uri.toString());
    }catch(e){
      throw FetchDataException('message',uri.toString());
    }
  }

//---------------------------------put------------------------------------------
  Future<dynamic> put(String url,
      {required Map<String, String> headers,
      required Map<String, String> body}) async {
    try{
      http.Response response =
      await http.put(Uri.parse(url), headers: headers, body: body);
      debugPrint(response.body);
      return _processingException(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotResponseException(
          'API not responded in time', url.toString());
    }

  }

//----------------------------------------------------------------------------

  dynamic _processingException(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:

        debugPrint("This is statusCode in baseClint ${response.statusCode}");
        debugPrint("This is body in baseClint \n ${response.body}");
          return jsonDecode(response.body);

      case 400:
        debugPrint("This is statusCode in baseClint ${response.statusCode}");
        debugPrint("This is body in baseClint \n ${response.body}");
        throw BadRequestException(jsonDecode(response.body)["message"],
            response.request?.url.toString());
      case 401:
      case 403:
      {
          debugPrint("This is statusCode in baseClint ${response.statusCode}");
          debugPrint("This is body in baseClint \n ${response.body}");
          showDialog(
              context: contextKey,
              builder: (context) => alertDialog(
                title: 'Warning',
                content: "Your account login in anther divice",
                onPressed: () {
                  provider.unauthenticatedLogout();
                },
              ));
          throw UnAuthorizedException(utf8.decode(response.bodyBytes),
              response.request!.url.toString());
        }
      case 422:
        debugPrint("This is statusCode in baseClint ${response.statusCode}");
        debugPrint("This is body in baseClint \n ${response.body}");
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
      {
          debugPrint("This is statusCode in baseClint ${response.statusCode}");
          debugPrint("This is body in baseClint \n ${response.body}");
          showDialog(
              context: contextKey,
              builder: (context) => alertDialog(
                title: 'Warning',
                content: "Your account login in anther divice",
                onPressed: () {
                  provider.unauthenticatedLogout();
                },
              ));
          throw FetchDataException(
              'Error occured with code ', response.request!.url.toString());
        }
    }
  }
}
