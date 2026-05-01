import 'package:flutter/material.dart';
import 'package:hospital_q/utils/app_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verify OTP", style: Theme.of(context).textTheme.headlineLarge),

            const SizedBox(height: 8),

            Text(
              "Sent to -(mobile number)",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black54),
            ),

            SizedBox(height: 32,),
            Center(
              child: MaterialPinField(
                length: 6,
                onCompleted: (pin) => print('PIN: $pin'),
                onChanged: (value) => print('Changed: $value'),
                theme: MaterialPinTheme(
                  shape: MaterialPinShape.outlined,
                  cellSize: Size(46, 54),
                  filledFillColor: Colors.white70,
                  focusedBorderColor: AppColor.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Center(child: Text("Resend OTP in ( Second )")),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: (){}, child: Text("Verify")),
            SizedBox(height: 8,),
            Center(child: Text("Wrong number? Go back"))


          ],
        ),
      ),
    );
  }
}
