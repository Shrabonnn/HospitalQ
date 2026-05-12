import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_q/view_model/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/app_snackbar.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/auth/welcome_view_model.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodController = TextEditingController();

  @override
  void dispose() {

    phoneController.dispose();
    ageController.dispose();
    bloodController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    await authVM.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {

    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text("Complete profile", style: Theme.of(context).textTheme.headlineLarge),

              const SizedBox(height: 8),

              Text(
                "Just a few details — one time only",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black54),
              ),

              const SizedBox(height: 80),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hint: Text("Phone Number")
                ),
              ),
              SizedBox(height: 16,),

              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hint: Text("Age")
                ),
              ),

              SizedBox(height: 16,),

              TextFormField(
                controller: bloodController,
                decoration: InputDecoration(
                    hint: Text("Blood Group ")
                ),
              ),
              SizedBox(height: 32,),
              ElevatedButton(
                onPressed: () async {
                  final welcomeVM = Provider.of<WelcomeViewModel>(context, listen: false);
                  final role = welcomeVM.isPatient ? "patient" : "staff";

                  String? error = await authVM.saveProfileDetails(
                    role: role,
                    phone: phoneController.text.trim(),
                    age: ageController.text.trim(),
                    bloodGroup: bloodController.text.trim(),
                  );

                  if (error == null) {
                    Navigator.pushReplacementNamed(context, RoutesName.navbar);
                  } else {
                    AppSnackbar.snackBarMessage(context, error);
                  }
                },
                child: authVM.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Save & Continue"),
              ),
              SizedBox(height: 24,),
              Center(child: Text("You can update this anytime in Profile"))
            ],
          ),
        ),
      ),
    );
  }
}
