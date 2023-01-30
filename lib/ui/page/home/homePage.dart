import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/authProvider.dart';
import '../../../core/provider/noteProvider.dart';
import '../../../resources/assets.dart';
import '../../../routing/navigations.dart';
import '../../../routing/router.dart';
import '../../../utils/helper.dart';
import '../../shared/widget/toDoTile.dart';
import 'addNote/BodeButtomSheet.dart';
import 'emptyNotePage.dart';

enum AppThemes { light, dark }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController addTaskController = TextEditingController();
  TextEditingController editTaskController = TextEditingController();
  var currentTheme = AppThemes.light;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      Provider.of<NoteProvider>(context, listen: false).fetchNote();
    });
    // Provider.of<NoteProvider>(context, listen: false).fetchNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NoteProvider>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Consumer<NoteProvider>(builder: (context, value, child) {
          return FloatingActionButton(
            backgroundColor: const Color(0xFF252525),
            onPressed: () {
              addTaskController.clear();
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => BottomSheetPage(
                    isLoading: value.isLoadingButton,
                        noteController: addTaskController,
                        text: "Add Note",
                        hintText: "Type Something",
                        buttonText: "Save",
                        onPressed: () {
                          value.createNote(addTaskController.text);
                          addTaskController.clear();
                        },
                      ));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          );
        }),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90.h,
        backgroundColor: Colors.transparent,
        title: const Text('Notes'),
        actions: [
           CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF3B3B3B),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Color(0xFF21AA93),
              ),
              onPressed: (){
                ServiceNavigation.serviceNavi
                    .pushNamedWidget(RouteGenerator.searchPage);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            ImageAssets.splashLogo,
            height: 50.h,
            width: 50.w,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF3B3B3B),
            child: Consumer<AuthProvider>(builder: (context, auth, child) {
              return IconButton(
                  onPressed: () {
                    ServiceNavigation.serviceNavi
                        .pushNamedWidget(RouteGenerator.settingPage);
                    // note.ClearTask();
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Color(0xFF21AA93),
                  ));
            }),
          ),
        ],
      ),

      body: provider.isLoadingPage
          ? const Center(child: CircularProgressIndicator())
          : provider.tasks.isNotEmpty
              ?
      Consumer<NoteProvider>(
          builder: (context, value, child) =>
              GroupedListView(
                elements: value.tasks,
                groupBy: (elements) => elements.createdAt.substring(0, 10),
                groupSeparatorBuilder: (value) => Container( margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),height: 30.h,child: Text(value)),
                groupHeaderBuilder: null,
                itemBuilder: (context, element) => ToDoTile(
                  taskName: element.title,
                  deleteFunction: (val) {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            alertDialog(
                          title: "Delete Note",
                          content: "Are you sure you want delete this note ?",
                          onPressed: () {
                            value.delete(element.id);
                          },
                        ));
                  },

                  editFunction: (val) {
                    editTaskController.text = element.title;
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => BottomSheetPage(
                          noteController: editTaskController,
                          text: "Edit Note",
                          hintText: "Type Something",
                          buttonText: "Save",
                          onPressed: () {
                            value.update(
                                id: element.id,
                                titel: editTaskController.text);
                            // editTaskController.clear();
                          },
                        ));
                  },
                ),
              )
      )
              : const EmptyNotePage()
    );
  }
}


// value.tasks![index].id, editTaskController.text
