import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedRole = "Patient";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome!",style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text('I am joining as a...',style:Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black54
            )),
            SizedBox(height: 48,),


            // Patient Card
            _buildRoleCard(
              title: "Patient",
              subtitle: "Book tokens, track queue",
              isSelected: selectedRole == "Patient",
              onTap: () {
                setState(() {
                  selectedRole = "Patient";
                });
              },
            ),

            const SizedBox(height: 16),

            // Hospital Staff Card
            _buildRoleCard(
              title: "Hospital Staff",
              subtitle: "Manage queue, call patients",
              isSelected: selectedRole == "Hospital Staff",
              onTap: () {
                setState(() {
                  selectedRole = "Hospital Staff";
                });
              },
            ),

            const SizedBox(height: 60),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("Staff accounts are created by hospital admin only. Contact your hospital IT department."),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
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
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
              : null,
        ),
        child: Row(
          children: [

            Icon(
              title == "Patient" ? Icons.person : Icons.medical_services,
              size: 28,
              color: isSelected ? Colors.blue : Colors.grey.shade600,
            ),
            const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.blue.shade900 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // Selection Indicator
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}

