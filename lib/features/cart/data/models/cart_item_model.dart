import '../../../foods/data/models/food_model.dart';

/// One line in the (local) cart.
class CartItemModel {
  final FoodModel food;
  final int quantity;

  CartItemModel({required this.food, required this.quantity});

  int get id => food.id;
  String get name => food.name;
  String? get imageUrl => food.imageUrl;
  double get price => food.price;
  double get total => price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      food: FoodModel.fromJson(Map<String, dynamic>.from(json['product'] as Map)),
      quantity: (json['quantity'] as num? ?? 1).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {'product': food.toJson(), 'quantity': quantity};
}
