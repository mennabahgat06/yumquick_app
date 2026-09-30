import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../orders/presentation/my_orders_view.dart';
import 'update_profile_view.dart';
import 'settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerYellow,
      body: Column(
        children: [
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 40, color: AppColors.headerYellow),
                  ),
                  SizedBox(height: 10),
                  Text('John Smith',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('LoremIpsum@email.com',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
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
                children: [
                  _buildProfileTile(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UpdateProfileView())),
                  ),
                  _buildProfileTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MyOrdersView())),
                  ),
                  _buildProfileTile(
                    icon: Icons.favorite_border,
                    title: 'My Favorites',
                    onTap: () {},
                  ),
                  _buildProfileTile(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsView())),
                  ),
                  const Divider(),
                  _buildProfileTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    color: Colors.red,
                    onTap: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = AppColors.textDark,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title,
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
