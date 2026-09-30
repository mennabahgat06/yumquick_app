import 'package:flutter/material.dart';
import 'core/utils/app_colors.dart';
import 'features/auth/presentation/welcome_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YumQuick',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryOrange),
        useMaterial3: true,
      ),
      home: const WelcomeView(),
    );
  }
}