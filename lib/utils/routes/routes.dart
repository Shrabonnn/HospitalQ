import 'package:flutter/material.dart';
import 'package:hospital_q/utils/routes/routes_name.dart';
import 'package:hospital_q/view/auth/login_screen.dart';
import 'package:hospital_q/view/auth/register_screen.dart';
import 'package:hospital_q/view/auth/verify_otp_screen.dart';
import 'package:hospital_q/view/auth/welcome_screen.dart';
import 'package:hospital_q/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:hospital_q/view/profile/profile_setting_screen.dart';
import 'package:hospital_q/view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting){
    switch(setting.name){
      case RoutesName.splash_screen:
        return MaterialPageRoute(builder: (context)=> SplashScreen());
      case RoutesName.register:
        return MaterialPageRoute(builder: (context)=> RegisterScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context)=> LoginScreen());
      case RoutesName.welcome:
        return MaterialPageRoute(builder: (context)=> WelcomeScreen());
      case RoutesName.profileSetting:
        return MaterialPageRoute(builder: (context)=> ProfileSettingScreen());
      case RoutesName.navbar:
        return MaterialPageRoute(builder: (context)=> BottomNavBar());

    // case RoutesName.verifyOtp:
      //   final args = setting.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => VerifyOtpScreen(
      //       vid: args["vid"],
      //       phoneNumber: args["phone"],
      //     ),
      //   );
      default :
        return MaterialPageRoute(builder: (context)=>Scaffold(
          body: Center(
            child: Text("No Route has been selected"),
          ),
        ));
    }
  }
}