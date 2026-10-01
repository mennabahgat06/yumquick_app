import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/utils/json_helper.dart';
import '../models/user_model.dart';

/// "users" folder of ecommerce.json. All bodies are form-data.
class AuthService {
  final ApiConsumer api = DioConsumer();

  /// POST login  {email, password}
  Future<void> login({required String email, required String password}) async {
    final response = await api.post(
      EndPoints.login,
      data: {'email': email, 'password': password},
      isFormData: true,
    );
    await _saveTokens(response);
  }

  /// POST register  {name, email, phone, password}
  /// If register does not return tokens we log in to get them.
  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    final data = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };

    final response = await api.post(EndPoints.register, data: data, isFormData: true);
    if (_readTokens(response)['access'] == null) {
      await login(email: email, password: password);
    } else {
      await _saveTokens(response);
    }
  }

  /// GET get_user_data
  Future<UserModel> getUserData() async {
    final response = await api.get(EndPoints.getUserData);
    return UserModel.fromJson(JsonHelper.readMap(response, ['user']));
  }

  /// PUT update_profile  {name, phone}
  Future<void> updateProfile({required String name, required String phone}) async {
    await api.put(
      EndPoints.updateProfile,
      data: {'name': name, 'phone': phone},
      isFormData: true,
    );
  }

  /// DELETE delete_user
  Future<void> deleteUser() async {
    await api.delete(EndPoints.deleteUser);
    await TokenStorage.clear();
  }

  Future<void> logout() => TokenStorage.clear();

  Future<void> _saveTokens(dynamic response) async {
    final tokens = _readTokens(response);
    final access = tokens['access'];
    if (access == null) throw const ApiException('No token returned from the server');
    await TokenStorage.saveTokens(accessToken: access, refreshToken: tokens['refresh']);
  }

  /// access_token + refresh_token, at the root or inside "data".
  Map<String, String?> _readTokens(dynamic response) {
    if (response is! Map) return {'access': null, 'refresh': null};
    final Map body = response['data'] is Map ? response['data'] : response;
    return {
      'access': (body['access_token'] ?? body['token'])?.toString(),
      'refresh': body['refresh_token']?.toString(),
    };
  }
}
