import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl {
  late final Dio _dio;
  late final FlutterSecureStorage _storage;

  AuthRepositoryImpl()
      : _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000')),
        _storage = const FlutterSecureStorage();

  AuthRepositoryImpl.forTest(dynamic dio, dynamic storage)
      : _dio = dio,
        _storage = storage;

  static Future<Dio> dioWithAuth() async {
    final storage = const FlutterSecureStorage();
    final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000'));
    final token = await storage.read(key: 'jwt_token');
    if (token != null) {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ));
    }
    return dio;
  }

  Future<String> login(String email, String password) async {
    final response = await _dio.post('/api/auth/login', data: {
      'email': email,
      'senha': password,
    });
    final token = response.data['token'] as String;
    await _storage.write(key: 'jwt_token', value: token);
    return token;
  }

  Future<void> register(String email, String senha, String nome,
      String descricao, String? base64Image) async {
    await _dio.post('/api/auth/register', data: {
      'nome': nome,
      'email': email,
      'senha': senha,
      'descricao': descricao,
      'imagem': base64Image ?? '',
    });
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}
