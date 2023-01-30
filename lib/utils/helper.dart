import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_pro/resources/colors.dart';

class Helpers {
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar({required String message, required bool status}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor:
          status ? Colors.green : const Color.fromARGB(255, 255, 17, 0),
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

class alertDialog extends StatelessWidget {
  alertDialog(
      {super.key, required this.title, required this.content, required this.onPressed});

  final String title;
  final String content;
  dynamic Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0.r))),
      backgroundColor: ColorManager.alertColor,
      actionsPadding: EdgeInsetsDirectional.only(start: 33.w, end: 33.w , bottom: 33.w),
      title: const Icon(
        Icons.warning,
        color: Color(0xFF606060),
        size: 29,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23.sp),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB0B0B0),
                  fixedSize: Size(112.w, 40.h)
              ),
              child: const Text("Ok"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAC0000),
                fixedSize: Size(112.w, 40.h)
              ),
              child: const Text("Cancel"),
            ),
          ],
        )
        // TextButton(onPressed: onPressed, child: const Text("Ok")),
        // TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
      ],
    );
  }
}
