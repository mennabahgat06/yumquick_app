import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerYellow,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'New Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full name', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const CustomTextField(hintText: 'Enter full name here'),
                    const SizedBox(height: 14),
                    const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const CustomTextField(hintText: 'example@example.com'),
                    const SizedBox(height: 14),
                    const Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const CustomTextField(hintText: '+123 456 789', keyboardType: TextInputType.phone),
                    const SizedBox(height: 14),
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const CustomTextField(hintText: '••••••••••••', isPassword: true),
                    const SizedBox(height: 14),
                    const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const CustomTextField(hintText: '••••••••••••', isPassword: true),
                    const SizedBox(height: 28),
                    CustomPrimaryButton(
                      text: 'Sign Up',
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}