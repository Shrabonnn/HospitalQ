import 'package:flutter/material.dart';
import 'package:hospital_q/utils/app_snackbar.dart';
import 'package:hospital_q/view_model/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodController = TextEditingController();

  bool _isLoadingData = true;   // ← separate loading flag for initial fetch

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    // always re-fetch to get latest data from Firestore
    await authVM.fetchUserProfile();

    final user = authVM.currentUser;

    if (user != null) {
      nameController.text = user.name;
      phoneController.text = user.phone;
      ageController.text = user.age;
      bloodController.text = user.bloodGroup;
    }

    if (mounted) {
      setState(() {
        _isLoadingData = false;   // ← now show the form
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    bloodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    final user = authVM.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: _isLoadingData   // ← use local flag, not user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoTile(label: "Email", value: user?.email ?? ''),
            const SizedBox(height: 8),
            _InfoTile(label: "Role", value: user?.role ?? ''),

            const SizedBox(height: 32),

            Text(
              "Edit Details",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Age",
                prefixIcon: Icon(Icons.cake),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: bloodController,
              decoration: const InputDecoration(
                labelText: "Blood Group",
                prefixIcon: Icon(Icons.bloodtype),
              ),
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: authVM.isLoading
                  ? null
                  : () async {
                final error = await authVM.updateProfile(
                  role: user?.role ?? '',
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  age: ageController.text.trim(),
                  bloodGroup: bloodController.text.trim(),
                );

                if (error == null) {
                  AppSnackbar.snackBarMessage(
                      context, "Profile updated successfully");
                } else {
                  AppSnackbar.snackBarMessage(context, error);
                }
              },
              child: authVM.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}