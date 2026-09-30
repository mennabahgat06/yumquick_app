import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/presentation/main_navigation_view.dart';
import '../data/services/auth_service.dart';

/// POST register (form-data: name, email, phone, password)
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.register(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
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
      title: 'New Account',
      bodyPadding: const EdgeInsets.all(24),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomTextField(
              label: 'Full name',
              hintText: 'Enter full name here',
              controller: _nameController,
              validator: (v) => Validators.required(v, 'Name'),
            ),
            CustomTextField(
              label: 'Email',
              hintText: 'example@example.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            CustomTextField(
              label: 'Mobile Number',
              hintText: '+123 456 789',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: Validators.phone,
            ),
            CustomTextField(
              label: 'Password',
              hintText: '••••••••••••',
              controller: _passwordController,
              isPassword: true,
              validator: Validators.password,
            ),
            CustomTextField(
              label: 'Confirm Password',
              hintText: '••••••••••••',
              controller: _confirmController,
              isPassword: true,
              validator: (v) => v != _passwordController.text ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 14),
            CustomPrimaryButton(text: 'Sign Up', isLoading: _isLoading, onPressed: _register),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
