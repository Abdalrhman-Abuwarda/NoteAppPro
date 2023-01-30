import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_pro/resources/values.dart';
import '../../../shared/widget/addNoteTextField.dart';
import '../../../shared/widget/mainButton.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key, required this.noteController, required this.text,required this.hintText, required this.buttonText, required this.onPressed, this.isLoading = false});

  final TextEditingController noteController;
  final String text;
  final String hintText;
  final String buttonText;
  final dynamic Function() onPressed;
  final bool isLoading;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(
        top: 30,
          start: 20,
          end: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 22,),
            textAlign: TextAlign.start,
          ),
          AddNoteTextField(hintText: hintText, controller: noteController, inbutType: TextInputType.text),
          addVerticalSpace(10.h),
          MainButton(label: buttonText, function: onPressed, isLoading: isLoading,),
          addVerticalSpace(20)
        ],
      ),
    );
  }
}
