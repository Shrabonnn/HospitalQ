import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital_q/resources/app_color.dart';
import 'package:hospital_q/utils/app_snackbar.dart';
import 'package:hospital_q/utils/routes/routes_name.dart';
import 'package:hospital_q/view/auth/verify_otp_screen.dart';
import 'package:provider/provider.dart';

import '../../resources/images.dart';
import '../../utils/utils.dart';
import '../../view_model/auth/auth_view_model.dart';
import '../../view_model/auth/welcome_view_model.dart';
import 'auth_widgets/divider_widget.dart';
import 'auth_widgets/google_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  ValueNotifier _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // 🔹 Important to avoid memory leak
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final authVM = Provider.of<AuthViewModel>(context, listen: false,);
    final welcomeVM = Provider.of<WelcomeViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formkey,
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
                    "Enter your email and password to continue",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 48),

                  Text(
                    "Email*",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    validator: (String? value) {
                      if(value == null || value.isEmpty){
                        return "Enter Email";
                      }
                      if(!value.contains("@")){
                        return "Enter valid Email";
                      }
                    },
                    focusNode: emailFocusNode,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "john@gmail.com",

                    ),
                    onFieldSubmitted:(value){
                      Utils.fieldFocusChange(context,emailFocusNode,passwordFocusNode);
                    },
                  ),

                  const SizedBox(height: 8),
                  Text(
                    "Password*",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 8),


                  ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Enter a valid Password";
                            }
                            return null;
                          },
                          focusNode: passwordFocusNode,
                          controller: passwordController,
                          obscureText: _obsecurePassword.value,
                          decoration: InputDecoration(
                            hintText: "password",
                            suffixIcon: InkWell(
                              onTap: (){
                                _obsecurePassword.value = !_obsecurePassword.value;
                              },
                              child:  _obsecurePassword.value ? Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined),
                            ),
                          ));
                    }
                  ),

                  const SizedBox(height: 24),

                  Consumer<AuthViewModel>(
                    builder: (context,vm,child){
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {

                            final role = welcomeVM.isPatient ? "patient" : "staff";
                            String? error = await authVM.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              role,
                            );

                            if (error == null) {
                              Navigator.pushReplacementNamed(context, RoutesName.navbar);
                            } else {
                              AppSnackbar.snackBarMessage(context, error);
                            }
                          }
                        },
                        child: vm.isLoading ? CircularProgressIndicator():Text("Sign In"),
                      );
                    },

                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamedAndRemoveUntil(context,  RoutesName.register, (_)=>false);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),

                  dividerWidget(),
                  const SizedBox(height: 40,),

                  // Firebase Google login
                  googleLoginWidget(),

                  const SizedBox(height: 40,),

                  Center(child: Text("New user? Account created automatically",textAlign: TextAlign.center,)),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Send OTP through phone
//   void sendcode()async{
//     try{
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: '+88${phoneNumber.text}',
//         verificationCompleted: (PhoneAuthCredential credential){},
//         verificationFailed: (FirebaseAuthException e){
//           AppSnackbar.snackBarMessage(context, (e.toString()));
//         },
//         codeSent: (String vid, int? token){
//           Navigator.pushNamed(context,
//             RoutesName.verifyOtp,
//             arguments: {
//               "vid": vid,
//               "phone": phoneNumber,
//             },
//           );
//         },
//         codeAutoRetrievalTimeout: (vid){}
//     );
//     }on FirebaseAuthException catch(e){
//       AppSnackbar.snackBarMessage(context, (e.toString()));
//     }catch(e){
//       AppSnackbar.snackBarMessage(context, (e.toString()));
//     }
//   }
}



