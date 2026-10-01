import '../../../../core/utils/json_helper.dart';

/// A dish. In the NTI e-commerce API dishes are "products".

class FoodModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final double rating;
  final int? categoryId;
  final bool isBestSeller;
  final bool isFavorite;

  FoodModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.imageUrl,
    this.rating = 0,
    this.categoryId,
    this.isBestSeller = false,
    this.isFavorite = false,
  });

  FoodModel copyWith({bool? isFavorite}) {
    return FoodModel(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      rating: rating,
      categoryId: categoryId,
      isBestSeller: isBestSeller,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    final categoryId = JsonHelper.readInt(json, ['category_id'], -1);
    return FoodModel(
      id: JsonHelper.readInt(json, ['id', 'product_id']),
      name: JsonHelper.readString(json, ['name', 'title', 'product_name']),
      description: JsonHelper.readString(json, ['description']),
      price: JsonHelper.readDouble(json, ['price']),
      imageUrl: JsonHelper.readImage(json, ['image_path', 'image', 'image_url']),
      rating: JsonHelper.readDouble(json, ['rating']),
      categoryId: categoryId == -1 ? null : categoryId,
      isBestSeller: JsonHelper.readBool(json, ['best_seller']),
      isFavorite: JsonHelper.readBool(json, ['is_favorite', 'favorite']),
    );
  }

  /// Saved in the local cart.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_path': imageUrl,
      'rating': rating,
      'category_id': categoryId,
      'best_seller': isBestSeller,
    };
  }
}
