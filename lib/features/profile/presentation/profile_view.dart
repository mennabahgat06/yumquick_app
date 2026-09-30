import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/curved_page.dart';
import '../../auth/data/models/user_model.dart';
import '../../auth/data/services/auth_service.dart';
import '../../auth/presentation/welcome_view.dart';
import '../../favorites/presentation/favorites_view.dart';
import '../../orders/presentation/my_orders_view.dart';
import 'settings_view.dart';
import 'update_profile_view.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_tile.dart';

/// Tab 3: GET get_user_data + menu (profile, orders, favorites, settings, logout, delete account).
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService _authService = AuthService();
  UserModel? _user;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final user = await _authService.getUserData();
      if (mounted) setState(() => _user = user);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _open(Widget screen) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    _load();
  }

  void _goToWelcome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeView()),
      (route) => false,
    );
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) _goToWelcome();
  }

  /// DELETE delete_user (after confirmation)
  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmDialog(
        title: 'Delete your account?',
        message: 'This cannot be undone.',
        confirmText: 'Delete',
      ),
    );
    if (confirmed != true) return;
    try {
      await _authService.deleteUser();
      if (mounted) _goToWelcome();
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      header: ProfileHeader(user: _user, error: _error),
      body: ListView(
        children: [
          ProfileTile(
            icon: Icons.person_outline,
            title: 'My Profile',
            onTap: () => _open(UpdateProfileView(user: _user)),
          ),
          ProfileTile(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () => _open(const MyOrdersView()),
          ),
          ProfileTile(
            icon: Icons.favorite_border,
            title: 'My Favorites',
            onTap: () => _open(const FavoritesView()),
          ),
          ProfileTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () => _open(const SettingsView()),
          ),
          const Divider(),
          ProfileTile(icon: Icons.logout, title: 'Log Out', color: Colors.red, onTap: _logout),
          ProfileTile(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            color: Colors.red,
            onTap: _deleteAccount,
          ),
        ],
      ),
    );
  }
}
