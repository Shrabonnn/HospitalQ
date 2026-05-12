import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_q/resources/app_color.dart';
import 'package:hospital_q/resources/images.dart';
import 'package:hospital_q/utils/routes/routes_name.dart';
import 'package:hospital_q/view_model/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {


  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;



  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _ctrl.forward();
    });


    Future.delayed(const Duration(milliseconds: 2500), () {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      (firebaseUser == null ) ? Navigator.pushNamed(context, RoutesName.welcome) : Navigator.pushNamed(context, RoutesName.navbar);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //── Logo mark ──────────────────────────────
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                     color: AppColor.soft,
                     shape: BoxShape.circle,
                   ),
                  child: Center(
                    child: Image.asset(Images.logo,width: 130,height: 120,),
                  ),
                ),

                const SizedBox(height: 24),

                // ── App name ───────────────────────────────
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hospital',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textMain,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'Q',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // ── Tagline ────────────────────────────────
                Text(
                  'Queue Tracker BD',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
