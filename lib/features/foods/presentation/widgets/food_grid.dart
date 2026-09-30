import 'package:flutter/material.dart';
import '../../../item_details/presentation/item_details_view.dart';
import '../../data/models/food_model.dart';
import 'food_grid_card.dart';

/// 2-column grid (used inside scroll views). Tap -> item details.
class FoodGrid extends StatelessWidget {
  final List<FoodModel> foods;

  const FoodGrid({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: foods.length,
      itemBuilder: (context, index) => FoodGridCard(
        food: foods[index],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ItemDetailsView(food: foods[index])),
        ),
      ),
    );
  }
}
