import 'package:flutter/material.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
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
                decoration: InputDecoration(
                  hint: Text("Full Name")
                ),
              ),
              SizedBox(height: 16,),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hint: Text("Age")
                ),
              ),

              SizedBox(height: 16,),

              TextFormField(
                decoration: InputDecoration(
                    hint: Text("Blood Group ")
                ),
              ),
              SizedBox(height: 32,),
              ElevatedButton(onPressed: (){}, child: Text("Save & Continue")),
              SizedBox(height: 24,),
              Center(child: Text("You can update this anytime in Profile"))
            ],
          ),
        ),
      ),
    );
  }
}
