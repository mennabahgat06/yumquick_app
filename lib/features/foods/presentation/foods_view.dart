import 'package:flutter/material.dart';
import '../../../core/widgets/curved_page.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../data/models/food_model.dart';
import '../data/services/food_service.dart';
import 'widgets/food_grid.dart';

/// Full list of foods: "View All" (list is passed in) or search (GET foods?q=).
class FoodsView extends StatefulWidget {
  final String title;
  final String query;
  final List<FoodModel>? foods;

  const FoodsView({super.key, required this.title, this.query = '', this.foods});

  @override
  State<FoodsView> createState() => _FoodsViewState();
}

class _FoodsViewState extends State<FoodsView> {
  final FoodService _foodService = FoodService();
  late List<FoodModel> _foods = widget.foods ?? [];
  late bool _isLoading = widget.foods == null;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.foods == null) _search();
  }

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final foods = await _foodService.getFoods(query: widget.query);
      if (mounted) setState(() => _foods = foods);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      title: widget.query.isEmpty ? widget.title : '"${widget.query}"',
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingView();
    if (_error != null) return ErrorView(message: _error!, onRetry: _search);
    if (_foods.isEmpty) return const EmptyView(icon: Icons.fastfood, message: 'No dishes found');
    return SingleChildScrollView(child: FoodGrid(foods: _foods));
  }
}
