import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_wallet_app/data/repositories/auth_repository_impl.dart';

class MockDio {
  Future<Map<String, dynamic>> Function(String, {Map<String, dynamic>? data})?
      onPost;
  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? data}) async {
    if (onPost != null) {
      return await onPost!(path, data: data);
    }
    throw UnimplementedError();
  }
}

class MockStorage {
  String? _token;
  Future<void> write({required String key, required String? value}) async {
    if (key == 'jwt_token') _token = value;
  }

  Future<String?> read({required String key}) async {
    if (key == 'jwt_token') return _token;
    return null;
  }

  Future<void> delete({required String key}) async {
    if (key == 'jwt_token') _token = null;
  }
}

void main() {
  group('AuthRepositoryImpl', () {
    late MockDio mockDio;
    late MockStorage mockStorage;
    late AuthRepositoryImpl repo;

    setUp(() {
      mockDio = MockDio();
      mockStorage = MockStorage();
      repo = AuthRepositoryImpl.forTest(mockDio, mockStorage);
    });

    test('login salva token', () async {
      mockDio.onPost = (path, {data}) async => {'token': 'abc123'};
      final token = await repo.login('test@test.com', '1234');
      expect(token, 'abc123');
      expect(await mockStorage.read(key: 'jwt_token'), 'abc123');
    });

    test('logout remove token', () async {
      await mockStorage.write(key: 'jwt_token', value: 'abc123');
      await repo.logout();
      expect(await mockStorage.read(key: 'jwt_token'), isNull);
    });
  });
}
