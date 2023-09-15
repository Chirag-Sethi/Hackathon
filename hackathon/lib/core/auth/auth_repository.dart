import 'package:hackathon/core/local_storage/secure_storage.dart';

class AuthRepository {
  AuthRepository._();

  /// Cached instance of [AuthRepository];
  static AuthRepository? _instance;

  static AuthRepository get instance {
    _instance ??= AuthRepository._();

    return _instance!;
  }

  final SecureStorageHelper _secureStorage = SecureStorageHelper.instance;

  Future<void> init() async {
    //Initialise tokens from secure storage
    refreshToken = await _refreshToken;
    accessToken = await _accessToken;
  }

  static String? refreshToken;
  static String? accessToken;

  Future<String?> get _refreshToken async {
    return await _secureStorage.read('refreshToken');
  }


  Future<String?> get _accessToken async {
    return await _secureStorage.read('accessToken');
  }

  Future<void> setRefreshToken(String token) async {
    refreshToken = token;
    return await _secureStorage.write('refreshToken', token);
  }

 
  

  Future<void> setAccessToken(String token) async {
    accessToken = token;
    return await _secureStorage.write('accessToken', token);
  }

  Future<void> clearAccessToken() async {
    return await _secureStorage.delete('accessToken');
  }

  static bool get isLoggedIn {
    return accessToken != null;
  }
}
