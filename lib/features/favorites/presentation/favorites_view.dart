import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../foods/data/models/food_model.dart';
import '../../foods/presentation/widgets/food_list_card.dart';
import '../../item_details/presentation/item_details_view.dart';
import '../data/services/favorite_service.dart';

/// GET favorites, heart -> DELETE favorites/{id}
class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final FavoriteService _favoriteService = FavoriteService();
  List<FoodModel> _favorites = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final favorites = await _favoriteService.getFavorites();
      if (mounted) setState(() => _favorites = favorites);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _remove(FoodModel food) async {
    try {
      await _favoriteService.remove(food.id);
      if (mounted) setState(() => _favorites.remove(food));
    } catch (e) {
      if (mounted) AppSnackBar.show(context, e.toString(), isError: true);
    }
  }

  Future<void> _open(FoodModel food) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemDetailsView(food: food)),
    );
    _load(); // the user may un-favorite from the details screen
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(title: 'My Favorites', body: _buildBody());
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _load);
    if (_favorites.isEmpty) {
      return const EmptyView(icon: Icons.favorite_border, message: 'No favorites yet');
    }
    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (_, index) {
        final food = _favorites[index];
        return FoodListCard(
          food: food,
          onTap: () => _open(food),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.primaryOrange),
            onPressed: () => _remove(food),
          ),
        );
      },
    );
  }
}
