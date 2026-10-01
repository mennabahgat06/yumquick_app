import '../../../../core/storage/cart_storage.dart';
import '../../../foods/data/models/food_model.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

/// Local cart (saved on the device). Sent to the API at checkout (place_order).
class CartService {
  Future<CartModel> getCart() async {
    final lines = await CartStorage.getLines();
    return CartModel(items: lines.map(CartItemModel.fromJson).toList());
  }

  /// Adds the product, or increases its quantity if already in the cart.
  Future<void> addToCart({required FoodModel food, int quantity = 1}) async {
    final cart = await getCart();
    final items = [...cart.items];
    final index = items.indexWhere((item) => item.id == food.id);
    if (index >= 0) {
      items[index] = CartItemModel(food: food, quantity: items[index].quantity + quantity);
    } else {
      items.add(CartItemModel(food: food, quantity: quantity));
    }
    await CartStorage.saveLines(items.map((item) => item.toJson()).toList());
  }

  Future<void> removeItem(int foodId) async {
    final cart = await getCart();
    final items = cart.items.where((item) => item.id != foodId).toList();
    await CartStorage.saveLines(items.map((item) => item.toJson()).toList());
  }

  Future<void> clear() => CartStorage.clear();
}
