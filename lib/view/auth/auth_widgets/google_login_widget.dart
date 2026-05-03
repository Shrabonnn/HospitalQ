import 'package:flutter/material.dart';

import '../../../resources/app_color.dart';
import '../../../resources/images.dart';

class googleLoginWidget extends StatelessWidget {
  const googleLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Firebase Google Login");
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              Images.google,
              width: 34,
              height: 34,
            ),

            const Text(
              "Continue with Google",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}