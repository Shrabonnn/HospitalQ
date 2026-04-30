import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../view_model/auth/welcome_view_model.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final welcomeProvider = Provider.of<WelcomeViewModel>(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Welcome!",
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            Text(
              "I am joining as a...",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 48),

            _buildRoleCard(
              context: context,
              title: "Patient",
              subtitle: "Book tokens, track queue",
              isSelected: welcomeProvider.selectedRole == "Patient",
              onTap: (){
                welcomeProvider.selectRole("Patient");
              },
            ),

            const SizedBox(height: 16),

            _buildRoleCard(
              context: context,
              title: "Hospital Staff",
              subtitle: "Manage queue, call patients",
              isSelected: welcomeProvider.selectedRole == "Hospital Staff",
              onTap: (){
                welcomeProvider.selectRole("Hospital Staff");
              },
            ),

            const SizedBox(height: 60),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Staff accounts are created by hospital admin only. Contact your hospital IT department.",
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {

                print(welcomeProvider.selectedRole);

              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 1.0 : 1.0,
          ),
        ),
        child: Row(
          children: [

            Icon(
              title == "Patient"
                  ? Icons.person
                  : Icons.medical_services,
              color: isSelected
                  ? Colors.blue
                  : Colors.grey,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),

                  Text(subtitle),
                ],
              ),
            ),

            if(isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 28,
              )
          ],
        ),
      ),
    );
  }
}