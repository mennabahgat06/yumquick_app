import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/food_model.dart';

/// Big image + name + price + description (Menu list).
class FoodListCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;
  final Widget? trailing;

  const FoodListCard({super.key, required this.food, required this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(url: food.imageUrl, height: 140, width: double.infinity, radius: 16),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(food.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Text(PriceFormatter.format(food.price),
                    style: const TextStyle(
                        color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                if (trailing != null) trailing!,
              ],
            ),
            Text(food.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
