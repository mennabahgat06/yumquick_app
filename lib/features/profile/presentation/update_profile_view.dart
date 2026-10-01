import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/data/services/auth_service.dart';

/// PUT update_profile (form-data: name, phone)
class UpdateProfileView extends StatefulWidget {
  final UserModel? user;

  const UpdateProfileView({super.key, this.user});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController =
      TextEditingController(text: widget.user?.name ?? '');
  late final TextEditingController _phoneController =
      TextEditingController(text: widget.user?.phone ?? '');
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.updateProfile(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
      );
      if (!mounted) return;
      AppSnackBar.show(context, 'Profile updated');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      title: 'My Profile',
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: AppNetworkImage(
                url: widget.user?.imageUrl,
                width: 92,
                height: 92,
                radius: 46,
                placeholderIcon: Icons.person,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Full Name',
              hintText: 'John Smith',
              controller: _nameController,
              validator: (v) => Validators.required(v, 'Name'),
            ),
            CustomTextField(
              label: 'Phone Number',
              hintText: '+123 567 89000',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: Validators.phone,
            ),
            const SizedBox(height: 24),
            CustomPrimaryButton(text: 'Update Profile', isLoading: _isLoading, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
