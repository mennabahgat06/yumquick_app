import 'package:flutter/material.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../foods/data/models/food_model.dart';
import '../../foods/data/services/food_service.dart';
import '../../foods/presentation/foods_view.dart';
import '../../foods/presentation/widgets/best_seller_list.dart';
import '../../foods/presentation/widgets/food_grid.dart';
import '../data/models/slider_model.dart';
import '../data/services/home_service.dart';
import 'widgets/home_header.dart';
import 'widgets/slider_banner.dart';
import 'widgets/section_header.dart';

/// Tab 1: GET sliders, best_seller_products, top_rated_products.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FoodService _foodService = FoodService();
  final HomeService _homeService = HomeService();
  List<SliderModel> _sliders = [];
  List<FoodModel> _bestSellers = [];
  List<FoodModel> _recommended = [];
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
      final results = await Future.wait([
        _homeService.getSliders(),
        _foodService.getBestSellers(),
        _foodService.getRecommended(),
      ]);
      if (!mounted) return;
      setState(() {
        _sliders = results[0] as List<SliderModel>;
        _bestSellers = results[1] as List<FoodModel>;
        _recommended = results[2] as List<FoodModel>;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openFoods(String title, {String query = '', List<FoodModel>? foods}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FoodsView(title: title, query: query, foods: foods)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      header: HomeHeader(
        onSearch: (query) {
          if (query.trim().isNotEmpty) _openFoods('Search', query: query.trim());
        },
      ),
      bodyPadding: const EdgeInsets.all(16),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _load);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        children: [
          SectionHeader(
            title: 'Best Seller',
            onViewAll: () => _openFoods('Best Seller', foods: _bestSellers),
          ),
          const SizedBox(height: 12),
          BestSellerList(foods: _bestSellers),
          const SizedBox(height: 16),
          SliderBanner(sliders: _sliders),
          const SizedBox(height: 16),
          SectionHeader(
            title: 'Recommend',
            onViewAll: () => _openFoods('Recommend', foods: _recommended),
          ),
          const SizedBox(height: 12),
          FoodGrid(foods: _recommended),
        ],
      ),
    );
  }
}
