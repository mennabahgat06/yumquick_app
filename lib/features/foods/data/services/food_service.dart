import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/favorite_storage.dart';
import '../../../../core/utils/json_helper.dart';
import '../models/food_model.dart';

/// Dishes = "products" of the NTI e-commerce API.
class FoodService {
  final ApiConsumer api = DioConsumer();

  /// GET products
  Future<List<FoodModel>> getAll() => _getFoods(EndPoints.products);

  /// GET best_seller_products  (Home "Best Seller")
  Future<List<FoodModel>> getBestSellers() => _getFoods(EndPoints.bestSellerProducts);

  /// GET top_rated_products  (Home "Recommend")
  Future<List<FoodModel>> getRecommended() => _getFoods(EndPoints.topRatedProducts);

  /// GET products/search?q=
  Future<List<FoodModel>> search(String query) {
    return _getFoods(EndPoints.searchProducts, {'q': query});
  }

  /// Menu: no "by category" endpoint -> filter GET products by category_id.
  Future<List<FoodModel>> getFoods({int? categoryId, String query = ''}) async {
    final foods = query.isNotEmpty ? await search(query) : await getAll();
    if (categoryId == null) return foods;
    return foods.where((food) => food.categoryId == categoryId).toList();
  }

  Future<List<FoodModel>> _getFoods(String path, [Map<String, dynamic>? query]) async {
    final response = await api.get(path, queryParameters: query);
    final favoriteIds = await FavoriteStorage.getIds();
    return JsonHelper.readList(response, ['products'])
        .map(FoodModel.fromJson)
        .map((f) => favoriteIds.contains(f.id) ? f.copyWith(isFavorite: true) : f)
        .toList();
  }
}
