import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_q/resources/app_color.dart';
import 'package:hospital_q/utils/app_snackbar.dart';
import 'package:hospital_q/utils/routes/routes_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {

  final String vid;
  final String phoneNumber;
  const VerifyOtpScreen({super.key, required this.vid, required this.phoneNumber});


  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  // otp store
  var code ="";
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
              "Sent to ${widget.phoneNumber}",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black54),
            ),

            SizedBox(height: 32,),
            Center(
              child: MaterialPinField(
                length: 6,
                onCompleted: (pin) => print('PIN: $pin'),
                onChanged: (value) => code = value,
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
            ElevatedButton(onPressed: (){
              signIn();
            }, child: Text("Verify")),
            SizedBox(height: 8,),
            Center(child: Text("Wrong number? Go back"))


          ],
        ),
      ),
    );
  }

  void signIn() async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.vid,
        smsCode: code
    );

    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((
          value) {
        Navigator.pushNamed(context, RoutesName.welcome);
      });
    }on FirebaseAuthException catch(e){
      AppSnackbar.snackBarMessage(context, e.toString());
    }catch(e){
      AppSnackbar.snackBarMessage(context, e.toString());}
  }
}
