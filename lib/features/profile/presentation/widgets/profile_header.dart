import 'package:flutter/material.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../auth/data/models/user_model.dart';

/// Avatar + name + email in the yellow header.
class ProfileHeader extends StatelessWidget {
  final UserModel? user;
  final String? error;

  const ProfileHeader({super.key, this.user, this.error});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          AppNetworkImage(
            url: user?.imageUrl,
            width: 72,
            height: 72,
            radius: 36,
            placeholderIcon: Icons.person,
          ),
          const SizedBox(height: 10),
          Text(
            user?.name ?? (error == null ? 'Loading...' : 'Guest'),
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            user?.email ?? error ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
