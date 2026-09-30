import 'package:flutter/material.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../item_details/presentation/item_details_view.dart';
import '../../data/models/food_model.dart';

/// Horizontal list of small square food images.
class BestSellerList extends StatelessWidget {
  final List<FoodModel> foods;

  const BestSellerList({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ItemDetailsView(food: foods[index])),
          ),
          child: AppNetworkImage(url: foods[index].imageUrl, width: 80, height: 90, radius: 14),
        ),
      ),
    );
  }
}
