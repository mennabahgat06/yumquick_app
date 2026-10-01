import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

/// Small dashes under the text; the current page is a longer orange dash.
class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PageIndicator({super.key, required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 22 : 12,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryOrange : AppColors.inputFill,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
