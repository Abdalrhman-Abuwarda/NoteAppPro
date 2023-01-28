import 'package:flutter/material.dart';
import 'package:note_app_pro/core/data/local/sharedController.dart';

class ThemeProvider extends ChangeNotifier{
   Color color1 = Color(int.parse(SharedPrefController().getColor1()));
   // Color color1 = Color(0xFF0074E1);
   Color color2 = Color(int.parse(SharedPrefController().getColor2()));

   double fontSize = 20;

   void changeFontSize(double value){
     fontSize = value;
     notifyListeners();
   }

   void changeColor(String col1,String col2){
     color1 = Color(int.parse(col1));
     SharedPrefController().saveColor1(color: col1.toString());
     debugPrint(SharedPrefController().getColor1());
     SharedPrefController().saveColor2(color: col2.toString());
     color2 = Color(int.parse(col2));
     notifyListeners();
   }

  // void changeColor2(){
  //   color1 = const Color(0xFFcc2b5e1);
  //   color2 = const Color(0xFF753a88);
  //   notifyListeners();
  // }
  //
  // void changeColor3(){
  //   color1 = const Color(0xFF000428);
  //   color2 = const Color(0xFF004e92);
  //   notifyListeners();
  // }
  // void changeColor4(){
  //   color1 = const Color(0xFFdd5e89);
  //   color2 = const Color(0xFFf7bb97);
  //   notifyListeners();
  // }
  //
  // void initColor(){
  //    color1 = const Color(0xFF0074E1);
  //    color2 = const Color(0xFF6BF5DE);
  //   notifyListeners();
  // }
}