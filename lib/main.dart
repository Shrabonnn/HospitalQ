import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_q/resources/app_color.dart';
import 'package:hospital_q/utils/routes/routes.dart';
import 'package:hospital_q/utils/routes/routes_name.dart';
import 'package:hospital_q/view/auth/welcome_screen.dart';
import 'package:hospital_q/view/splash/splash_screen.dart';
import 'package:hospital_q/view_model/auth/auth_view_model.dart';
import 'package:hospital_q/view_model/auth/welcome_view_model.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> WelcomeViewModel()),
          ChangeNotifierProvider(create: (_)=> AuthViewModel()),
        ],
        child: MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        scaffoldBackgroundColor: AppColor.background,

        //Default Color
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          brightness: Brightness.light,
        ),

        //Default Theme
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme,
        ).copyWith(
          bodyMedium: GoogleFonts.inter(
            textStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
              color: Colors.black54,
            ),
          ),
          headlineLarge: GoogleFonts.inter(
            textStyle: ThemeData.light().textTheme.titleLarge?.copyWith(
                color: AppColor.textMain,
                fontWeight: FontWeight.w700
            ),),
          titleLarge: GoogleFonts.inter(
            textStyle: ThemeData.light().textTheme.titleLarge?.copyWith(
                color: AppColor.textMain,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(

          filled: true,
          fillColor: Colors.white70,

          hintStyle: const TextStyle(
            color: Colors.black38,
            fontSize: 14,
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColor.primary,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
              //fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12)
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )
        ),
      ),
      initialRoute: RoutesName.splash_screen,
      onGenerateRoute: Routes.generateRoute,
    ));
  }
}
