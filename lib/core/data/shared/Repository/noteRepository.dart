
import 'package:flutter/material.dart';
import 'package:note_app_pro/core/data/shared/apiEndPoint.dart';
import 'dart:io';
import 'package:note_app_pro/core/data/shared/baseClient.dart';
import '../../local/sharedController.dart';
import '../apiHelper.dart';

class NoteApiRepository extends EndPoint with ApiHelper {


//-----------------------------create-------------------------------------------


  Future<dynamic> createRepository({required String title}) async {
    return await BaseClient.baseClient.post(super.noteUri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${SharedPrefController().getUser().token}',
      HttpHeaders.acceptHeader: 'application/json'},
        body: {"title": title});
  }


//-----------------------------fetchNote----------------------------------------

  Future<dynamic> fetchRepository() async {
    debugPrint("This is in fetchRepository");
    debugPrint("This is token in fetchRepository \n ${SharedPrefController().getUser().token}");
    return await BaseClient.baseClient.get(super.getNoteUri, {
      HttpHeaders.authorizationHeader:
      'Bearer ${SharedPrefController().getUser().token}'
    });
  }

//----------------------------deleteNote----------------------------------------

  Future<dynamic> deleteRepository(int id) async {
    return await BaseClient.baseClient.delete('${super.noteUri}/$id', {
      HttpHeaders.authorizationHeader:
      'Bearer ${SharedPrefController().getUser().token}',
    });
  }

//-----------------------------updateNote---------------------------------------

  Future<dynamic> updateRepository(int id, String titel) async {
    return await BaseClient.baseClient.put('${super.noteUri}/$id',
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${SharedPrefController().getUser().token}'},
        body: {"title": titel});
  }

}
