import 'package:flutter/material.dart';
import 'package:hospital_q/utils/app_color.dart';

import '../../utils/images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Text(
                "Sign in",
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 8),

              Text(
                "Enter your phone number to continue",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 48),

              Text(
                "Phone number",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "01XXXXXXXXX",
                )),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Send OTP",
                ),
              ),
              const SizedBox(height: 40,),

              dividerWidget(),
              const SizedBox(height: 40,),

              // Firebase Google login
              _googleLoginWidget(),

              const SizedBox(height: 40,),

              Center(child: Text("New user? Account created automatically",textAlign: TextAlign.center,)),


            ],
          ),
        ),
      ),
    );
  }
}

class _googleLoginWidget extends StatelessWidget {
  const _googleLoginWidget({
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

class dividerWidget extends StatelessWidget {
  const dividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.white70,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "OR",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}