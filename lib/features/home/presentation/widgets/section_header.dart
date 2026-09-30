import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// "Best Seller ............ View All >"
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({super.key, required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: const Text('View All >',
                style: TextStyle(color: AppColors.primaryOrange, fontSize: 12)),
          ),
      ],
    );
  }
}
