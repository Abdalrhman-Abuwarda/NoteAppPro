import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app_pro/core/models/apiResponce.dart';
import 'package:note_app_pro/core/models/taskModel.dart';
import 'package:provider/provider.dart';
import '../../routing/navigations.dart';
import '../../utils/helper.dart';
import '../data/shared/Repository/noteRepository.dart';
import '../data/shared/apiHelper.dart';
import 'authProvider.dart';

class NoteProvider extends ChangeNotifier with ApiHelper{

  List<Task> tasks = [];
  List<Task> searchTasks = [];
  // List<Task>? reverseTasks = [];
  final contextKey = ServiceNavigation.serviceNavi.navKey.currentContext!;
  var provider = Provider.of<AuthProvider>(
      ServiceNavigation.serviceNavi.navKey.currentContext!,
      listen: false);

  bool isLoadingButton = false;
  bool isLoadingPage = true;
  String queryString = "";


//---------------------------------createNote-----------------------------------
  Future<dynamic> createNote(String title) async {
    try {
      isLoadingButton = true;
      notifyListeners();
      dynamic dataResponse =
          await NoteApiRepository().createRepository(title: title);
      // ApiResponseModel response = ApiResponseModel.fromJson(dataResponse);
      debugPrint("This is status in provider${dataResponse["status"]}");
      if (dataResponse["status"]) {
        isLoadingButton = false;
        notifyListeners();
        Task task = Task.fromJson(dataResponse["data"]);
        tasks.add(task);
        Helpers.showSnackBar(message: dataResponse["message"], status: dataResponse["status"]);
        ServiceNavigation.serviceNavi.popFunction();
        debugPrint(task.title);
        notifyListeners();
      } else {
        showDialog(
            context: contextKey,
            builder: (context) => alertDialog(
                  title: 'Warning',
                  content: "Your account login in anther divice",
                  onPressed: () {
                    provider.logout();
                  },
                ));
      }
    } catch (error) {
      handleError(error);
      debugPrint('This is in Provider $error');
    }
    notifyListeners();
  }


//---------------------------------readNote-------------------------------------
  fetchNote() async {
    try {
      debugPrint("This is before dataResponse in fetchNote in provider ");
      var dataResponse = await NoteApiRepository().fetchRepository();
      debugPrint("This is dataResponse in fetchNote in provider \n $dataResponse");
      if(dataResponse["data"].isNotEmpty) {
        List<dynamic> dataList = dataResponse["data"];
        tasks = dataList.map((value) => Task.fromJson(value)).toList();
        isLoadingPage = false;
        debugPrint('this is First id task List before reverse \n ${tasks.first.id}');
        // reverseTasks = List.from(tasks!.reversed);
        // debugPrint('this is First id in reverseTasks \n ${reverseTasks!.first.id}');
        notifyListeners();
        Helpers.showSnackBar(message: '${dataResponse["message"]}', status: dataResponse["status"]);
      }
      else{
        tasks = [];
        isLoadingPage = false;
        notifyListeners();
      }
    } catch (error) {
      tasks = [];
      isLoadingPage = false;
      notifyListeners();
      handleError(error);
      debugPrint('This is in Provider in fetchNote \n $error');
      // Helpers.showSnackBar(message: '$error');
    }
    notifyListeners();

  }


//------------------------------------delete------------------------------------

  Future<dynamic> delete(int id) async {
    try {
      final dataResponse = await NoteApiRepository().deleteRepository(id);
      ApiResponseModel responseModel = ApiResponseModel.fromJson(dataResponse);
      if (responseModel.status) {
        tasks.removeWhere((item) => item.id == id);
        notifyListeners();
        ServiceNavigation.serviceNavi.popFunction();
        Helpers.showSnackBar(message: responseModel.message, status: responseModel.status);
        // Navigator.pop(contextKey);
        notifyListeners();
      } else {
        showDialog(
            context: contextKey,
            builder: (context) => alertDialog(
                  title: 'Warning',
                  content: "Your account login in anther divice",
                  onPressed: () {
                    provider.logout();
                  },
                ));
      }
    } catch (error) {
      handleError(error);
    }
    notifyListeners();
  }


//------------------------------------update------------------------------------

  Future<dynamic> update({
    required int id,
    required String titel,
  }) async {
    try {
      isLoadingButton = true;
      notifyListeners();
      dynamic dataResponse =
          await NoteApiRepository().updateRepository(id, titel);
      if(dataResponse["status"]){
        isLoadingButton = false;
        notifyListeners();
        int index = tasks.indexWhere((item) => item.id == id);
        tasks[index].title = titel;
        notifyListeners();
        Helpers.showSnackBar(message: dataResponse["message"], status: dataResponse["status"]);
        ServiceNavigation.serviceNavi.popFunction();
      }
    } catch (error) {
      handleError(error);
      debugPrint('This is in the Provider $error');
    }
    notifyListeners();
  }

//----------------------------------clearTask-----------------------------------
  void clearTask() {
    tasks =[];
    isLoadingPage = true;

    notifyListeners();
  }

//-------------------------------filterSearch-----------------------------------

  filterSearch(String query){
    if(query.isNotEmpty) {
      final suggestions = tasks.where((element) {
        final noteTitle = element.title.toLowerCase();
        final input = query.toLowerCase();
        return noteTitle.contains(input);
      }).toList();
      searchTasks = suggestions;
      notifyListeners();
    }
    else{
      searchTasks.clear();
      notifyListeners();
    }
  }

  clearSearchNote(TextEditingController controller){
    controller.clear();
    searchTasks.clear();
    notifyListeners();
  }


}
