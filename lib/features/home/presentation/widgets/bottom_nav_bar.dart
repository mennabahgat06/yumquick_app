import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// Orange rounded bottom bar with 3 icons.
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  static const List<IconData> _icons = [
    Icons.home_outlined,
    Icons.restaurant_menu,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.primaryOrange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < _icons.length; i++)
              IconButton(
                icon: Icon(
                  _icons[i],
                  color: currentIndex == i ? Colors.white : Colors.white60,
                  size: 28,
                ),
                onPressed: () => onTap(i),
              ),
          ],
        ),
      ),
    );
  }
}
