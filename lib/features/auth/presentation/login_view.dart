import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/presentation/main_navigation_view.dart';
import '../data/services/auth_service.dart';

/// POST login (form-data: email, password)
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationView()),
        (route) => false,
      );
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      title: 'Hello!',
      bodyPadding: const EdgeInsets.all(24),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text('Welcome', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Email',
              hintText: 'example@example.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            CustomTextField(
              label: 'Password',
              hintText: '••••••••••••',
              controller: _passwordController,
              isPassword: true,
              validator: Validators.password,
            ),
            const SizedBox(height: 22),
            CustomPrimaryButton(text: 'Log In', isLoading: _isLoading, onPressed: _login),
          ],
        ),
      ),
    );
  }
}
