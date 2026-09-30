import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerYellow,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text('My Profile', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: AppColors.inputFill,
                      child: Icon(Icons.person, size: 50, color: AppColors.primaryOrange),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const CustomTextField(hintText: 'John Smith'),
                  const SizedBox(height: 16),
                  const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const CustomTextField(hintText: '+123 567 89000'),
                  const Spacer(),
                  CustomPrimaryButton(
                    text: 'Update Profile',
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}