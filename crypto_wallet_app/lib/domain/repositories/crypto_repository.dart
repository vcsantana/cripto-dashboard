import '../entities/crypto.dart';

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCryptos();
  Future<List<Crypto>> searchCryptos(
      {String? nome, String? simbolo, String? tipo});
}
