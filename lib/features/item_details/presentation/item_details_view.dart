import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/custom_button.dart';
import '../../cart/data/services/cart_service.dart';
import '../../favorites/data/services/favorite_service.dart';
import '../../foods/data/models/food_model.dart';
import 'widgets/quantity_selector.dart';

/// Dish details (from the list), add to the local cart, POST add_to_favorite.
class ItemDetailsView extends StatefulWidget {
  final FoodModel food;

  const ItemDetailsView({super.key, required this.food});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  final CartService _cartService = CartService();
  final FavoriteService _favoriteService = FavoriteService();

  FoodModel get _food => widget.food;
  late bool _isFavorite = widget.food.isFavorite;
  int _count = 1;
  bool _isAdding = false;

  Future<void> _toggleFavorite() async {
    final newValue = !_isFavorite;
    setState(() => _isFavorite = newValue);
    try {
      if (newValue) {
        await _favoriteService.add(_food.id);
      } else {
        await _favoriteService.remove(_food.id);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isFavorite = !newValue); // undo
      AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  Future<void> _addToCart() async {
    setState(() => _isAdding = true);
    try {
      await _cartService.addToCart(food: _food, quantity: _count);
      if (!mounted) return;
      AppSnackBar.show(context, 'Added to cart');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isAdding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      title: _food.name,
      action: IconButton(
        icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border,
            color: AppColors.primaryOrange),
        onPressed: _toggleFavorite,
      ),
      body: ListView(
        children: [
          AppNetworkImage(url: _food.imageUrl, height: 220, width: double.infinity, radius: 20),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(PriceFormatter.format(_food.price),
                  style: const TextStyle(
                      color: AppColors.primaryOrange, fontSize: 24, fontWeight: FontWeight.bold)),
              QuantitySelector(
                quantity: _count,
                onChanged: (value) => setState(() => _count = value),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(_food.description, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 32),
          CustomPrimaryButton(text: 'Add to Cart', isLoading: _isAdding, onPressed: _addToCart),
        ],
      ),
    );
  }
}
