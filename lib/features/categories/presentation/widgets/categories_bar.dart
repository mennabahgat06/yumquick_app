import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import 'category_item.dart';

/// Horizontal list of categories; the selected one is highlighted.
class CategoriesBar extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selected;
  final ValueChanged<CategoryModel> onSelected;

  const CategoriesBar({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, index) {
          final category = categories[index];
          return CategoryItem(
            category: category,
            isSelected: category.id == selected?.id,
            onTap: () => onSelected(category),
          );
        },
      ),
    );
  }
}
