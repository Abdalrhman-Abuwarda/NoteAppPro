import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_pro/core/provider/noteProvider.dart';
import 'package:note_app_pro/resources/values.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../resources/assets.dart';
import '../../../utils/helper.dart';
import '../../shared/widget/mainTextField.dart';
import '../../shared/widget/searchTextFormField.dart';
import '../../shared/widget/toDoTile.dart';
import 'addNote/BodeButtomSheet.dart';

class SearchPage extends StatefulWidget {
   SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  TextEditingController editTaskController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value , child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 120.h,
          leading: Row(
            children: [
              Spacer(),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: const Color(0xFF3B3B3B),
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,)),
              ),

            ],
          ),
          title: SearchTextFormField(searchController: searchController, onPressed: () => value.clearSearchNote(searchController),
            onChange: (val) {
              value.filterSearch(val);
            } ,),
          centerTitle: true,
        ),

        body:
            value.searchTasks.isNotEmpty ?
        ListView.builder(
          itemCount: value.searchTasks.length,
            itemBuilder: (context, index) => ToDoTile(taskName: value.searchTasks[index].title,
              deleteFunction: (val) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        alertDialog(
                          title: "Delete Note",
                          content: "Are you sure you want delete this note ?",
                          onPressed: () {
                            value.delete(value.searchTasks[index].id);
                          },
                        ));
              },
              editFunction: (val) {
                editTaskController.text = value.searchTasks[index].title;
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
                            id: value.searchTasks[index].id,
                            titel: editTaskController.text);
                        // editTaskController.clear();
                      },
                    ));
              },))

                :
        const EmptyPage(),
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset(ImageAssets.searchImage)),
        addVerticalSpace(30.h),
        const Text("Note not found. Try searching again.")
      ],
    );
  }
}

