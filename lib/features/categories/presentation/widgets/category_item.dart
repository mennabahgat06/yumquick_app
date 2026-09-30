import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/category_model.dart';

/// Round category icon/image + name.
class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: isSelected ? AppColors.primaryOrange : AppColors.inputFill,
              foregroundImage:
                  category.imageUrl == null ? null : NetworkImage(category.imageUrl!),
              onForegroundImageError: category.imageUrl == null ? null : (_, __) {},
              child: Icon(Icons.fastfood,
                  color: isSelected ? Colors.white : AppColors.primaryOrange, size: 20),
            ),
            const SizedBox(height: 4),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primaryOrange : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
