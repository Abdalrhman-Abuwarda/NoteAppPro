import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/data/local/sharedController.dart';
import '../../resources/assets.dart';
import '../../resources/values.dart';
import '../../routing/navigations.dart';
import '../../routing/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      if(SharedPrefController().isLoggedIn()){
        ServiceNavigation.serviceNavi.pushNamedReplacement(RouteGenerator.homePage);
      }
      else{
        ServiceNavigation.serviceNavi.pushNamedReplacement(RouteGenerator.loginPage) ;
        SharedPrefController().saveColor1(color: "0xFF0074E1");
        SharedPrefController().saveColor2(color: "0xFF6BF5DE");
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("This is User ${SharedPrefController().getUser().email??"iiiii"}"),
            Image.asset(
              ImageAssets.splashLogo,
              height: 172.h,
              width: 172.w,
            ),
            SizedBox(
              height: AppSize.s32.h,
            ),
          ],
        ),
      ),
    );
  }
}
