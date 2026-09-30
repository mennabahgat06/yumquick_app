import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/favorite_storage.dart';
import '../../../foods/data/models/food_model.dart';
import '../../../foods/data/services/food_service.dart';

/// POST add_to_favorite {product_id}.
/// The API has no "get / remove favorite" endpoints, so the list is also saved
/// on the device (FavoriteStorage) and My Favorites is built from it.
class FavoriteService {
  final ApiConsumer api = DioConsumer();
  final FoodService _foodService = FoodService();

  Future<void> add(int foodId) async {
    await api.post(EndPoints.addToFavorite, data: {'product_id': foodId}, isFormData: true);
    await FavoriteStorage.setFavorite(foodId, true);
  }

  /// Removed on the device only (no API endpoint for it).
  Future<void> remove(int foodId) => FavoriteStorage.setFavorite(foodId, false);

  Future<List<FoodModel>> getFavorites() async {
    final all = await _foodService.getAll();
    return all.where((food) => food.isFavorite).toList();
  }
}
