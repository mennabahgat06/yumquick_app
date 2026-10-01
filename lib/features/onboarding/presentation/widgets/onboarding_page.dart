import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/onboarding_item.dart';
import 'page_indicator.dart';

/// Full image on top + white rounded card (icon, title, text, dots, button).
class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final int pageIndex;
  final int pageCount;
  final VoidCallback onNext;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.pageIndex,
    required this.pageCount,
    required this.onNext,
  });

  bool get _isLast => pageIndex == pageCount - 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: MediaQuery.of(context).size.height * 0.35,
          child: Image.asset(item.image, fit: BoxFit.cover),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(32, 28, 32, 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, color: AppColors.primaryOrange, size: 36),
                const SizedBox(height: 14),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textDark, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 24),
                PageIndicator(count: pageCount, currentIndex: pageIndex),
                const SizedBox(height: 28),
                SizedBox(
                  width: 160,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    ),
                    onPressed: onNext,
                    child: Text(
                      _isLast ? 'Get Started' : 'Next',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
