import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// Icon + title + arrow row in the profile menu.
class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = AppColors.textDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
