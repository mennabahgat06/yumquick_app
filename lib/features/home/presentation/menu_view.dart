import 'package:flutter/material.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/search_field.dart';
import '../../categories/data/models/category_model.dart';
import '../../categories/presentation/widgets/categories_bar.dart';
import '../../foods/data/models/food_model.dart';
import '../../foods/data/services/food_service.dart';
import '../../foods/presentation/widgets/food_list_card.dart';
import '../../item_details/presentation/item_details_view.dart';
import '../data/services/home_service.dart';

/// Tab 2: GET categories + GET products (filtered by category), search = products/search.
class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final FoodService _foodService = FoodService();
  final HomeService _homeService = HomeService();
  final TextEditingController _searchController = TextEditingController();

  List<CategoryModel> _categories = [];
  CategoryModel? _selected;
  List<FoodModel> _foods = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final categories = await _homeService.getCategories();
      if (!mounted) return;
      setState(() {
        _categories = categories;
        _selected = categories.isNotEmpty ? categories.first : null;
      });
      await _loadFoods();
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadFoods() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final foods = await _foodService.getFoods(
        categoryId: _selected?.id,
        query: _searchController.text.trim(),
      );
      if (mounted) setState(() => _foods = foods);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _selectCategory(CategoryModel category) {
    setState(() => _selected = category);
    _loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      header: Padding(
        padding: const EdgeInsets.all(4),
        child: SearchField(controller: _searchController, onSubmitted: (_) => _loadFoods()),
      ),
      body: Column(
        children: [
          CategoriesBar(
            categories: _categories,
            selected: _selected,
            onSelected: _selectCategory,
          ),
          const SizedBox(height: 12),
          Expanded(child: _buildFoods()),
        ],
      ),
    );
  }

  Widget _buildFoods() {
    if (_isLoading) return const LoadingView();
    if (_error != null) {
      return ErrorView(
        message: _error!,
        onRetry: _categories.isEmpty ? _loadCategories : _loadFoods,
      );
    }
    if (_foods.isEmpty) return const EmptyView(icon: Icons.fastfood, message: 'No dishes found');

    return ListView.builder(
      itemCount: _foods.length,
      itemBuilder: (context, index) => FoodListCard(
        food: _foods[index],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ItemDetailsView(food: _foods[index])),
        ),
      ),
    );
  }
}
