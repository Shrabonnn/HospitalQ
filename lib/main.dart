import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_q/utils/app_color.dart';
import 'package:hospital_q/utils/routes/routes.dart';
import 'package:hospital_q/utils/routes/routes_name.dart';
import 'package:hospital_q/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                fixedSize: Size.fromWidth(double.maxFinite),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8)
                )
            )
        ),
      ),
      initialRoute: RoutesName.splash_screen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
