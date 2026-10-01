import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';

/// Content of one onboarding page (design: 1-A, 1-B, 1-C).
class OnboardingItem {
  final String image;
  final IconData icon;
  final String title;
  final String description;

  const OnboardingItem({
    required this.image,
    required this.icon,
    required this.title,
    required this.description,
  });

  static const List<OnboardingItem> pages = [
    OnboardingItem(
      image: AppAssets.onboardingPizza,
      icon: Icons.receipt_long_outlined,
      title: 'Order For Food',
      description: 'Choose your favorite meals from the best restaurants around you in a few taps.',
    ),
    OnboardingItem(
      image: AppAssets.onboardingDessert,
      icon: Icons.credit_card_outlined,
      title: 'Easy Payment',
      description: 'Pay quickly and safely. Your order total is always clear before you confirm.',
    ),
    OnboardingItem(
      image: AppAssets.onboardingCoffee,
      icon: Icons.delivery_dining_outlined,
      title: 'Fast Delivery',
      description: 'Hot and fresh to your door. Follow your orders any time from your profile.',
    ),
  ];
}
