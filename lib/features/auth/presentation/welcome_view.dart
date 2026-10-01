import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import 'login_view.dart';
import 'register_view.dart';

/// Orange start screen: logo + Log In / Sign Up.
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryOrange,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.headerYellow, width: 4),
                ),
                child: const Icon(Icons.restaurant, color: AppColors.headerYellow, size: 60),
              ),
              const SizedBox(height: 20),
              const Text(
                'YUMQUICK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Delicious food from the best restaurants,\ndelivered quickly to your door.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const Spacer(),
              CustomPrimaryButton(
                text: 'Log In',
                backgroundColor: AppColors.headerYellow,
                textColor: AppColors.primaryOrange,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const LoginView())),
              ),
              const SizedBox(height: 14),
              CustomPrimaryButton(
                text: 'Sign Up',
                backgroundColor: Colors.white,
                textColor: AppColors.primaryOrange,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const RegisterView())),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
