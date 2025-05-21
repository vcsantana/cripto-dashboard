import 'package:dio/dio.dart';
import '../../domain/entities/crypto.dart';
import '../../domain/repositories/crypto_repository.dart';
import 'auth_repository_impl.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  @override
  Future<List<Crypto>> fetchCryptos() async {
    try {
      final dio = await AuthRepositoryImpl.dioWithAuth();
      final response = await dio.get('/api/crypto/');
      final data = response.data as List;
      return data
          .map((json) => Crypto(
                name: json['name'] ?? '',
                symbol: json['symbol'] ?? '',
                price: (json['price'] ?? '').toString(),
                percentChange: (json['percentChange'] ?? '').toString(),
                iconUrl: json['iconUrl'] ?? '',
              ))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar criptomoedas: $e');
    }
  }

  @override
  Future<List<Crypto>> searchCryptos(
      {String? nome, String? simbolo, String? tipo}) async {
    try {
      final dio = await AuthRepositoryImpl.dioWithAuth();
      final response = await dio.get(
        '/api/crypto/search',
        queryParameters: {
          if (nome != null && nome.isNotEmpty) 'nome': nome,
          if (simbolo != null && simbolo.isNotEmpty) 'simbolo': simbolo,
          if (tipo != null && tipo.isNotEmpty) 'tipo': tipo,
        },
      );
      final data = response.data as List;
      return data
          .map((json) => Crypto(
                name: json['name'] ?? '',
                symbol: json['symbol'] ?? '',
                price: (json['price'] ?? '').toString(),
                percentChange: (json['percentChange'] ?? '').toString(),
                iconUrl: json['iconUrl'] ?? '',
              ))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar criptomoedas: $e');
    }
  }
}
