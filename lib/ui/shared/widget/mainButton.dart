import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_pro/core/provider/themeProvider.dart';
import 'package:provider/provider.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key, required this.label,
      this.textColor = Colors.black,
      required this.function,
        this.isLoading = false,
      });

  final String label;
  final Color textColor;
  final Function() function;
  final bool isLoading ;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return Container(
        margin: EdgeInsetsDirectional.only(start: 44.w, end: 44.w),
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  theme.color1,
                  theme.color2,
                ])),
        child: ElevatedButton(
          onPressed: isLoading ? null : function,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            // shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: isLoading ? const CircularProgressIndicator() :
          Text(
            label,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),

        // MaterialButton(
        //   height: 0,
        //   onPressed: function,
        //   padding: const EdgeInsets.symmetric(vertical: 0),
        //   child: Text(label,
        //     style: TextStyle(
        //       color: textColor,
        //     ),
        //   ),
        //
        // ),
      );
    });
  }
}
