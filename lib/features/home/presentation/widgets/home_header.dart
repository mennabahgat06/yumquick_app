import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/greeting_helper.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../cart/presentation/cart_view.dart';

/// Search field + cart button + "Good Morning" message.
class HomeHeader extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const HomeHeader({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: SearchField(onSubmitted: onSearch)),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const CartView())),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.shopping_cart_outlined, color: AppColors.primaryOrange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(GreetingHelper.greeting(),
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(GreetingHelper.mealMessage(),
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
