import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_wallet_app/presentation/home/crypto_cubit.dart';
import 'package:crypto_wallet_app/domain/entities/crypto.dart';
import 'package:crypto_wallet_app/domain/repositories/crypto_repository.dart';

class MockCryptoRepository implements CryptoRepository {
  List<Crypto>? cryptosToReturn;
  bool throwError = false;

  @override
  Future<List<Crypto>> fetchCryptos() async {
    if (throwError) throw Exception('Erro de rede');
    return cryptosToReturn ?? [];
  }
}

void main() {
  group('CryptoCubit', () {
    late MockCryptoRepository mockRepo;
    late CryptoCubit cubit;

    setUp(() {
      mockRepo = MockCryptoRepository();
      cubit = CryptoCubit(mockRepo);
    });

    test('emite loading e loaded ao buscar criptos com sucesso', () async {
      mockRepo.cryptosToReturn = [
        Crypto(
            name: 'BTC',
            symbol: 'BTC',
            price: '1',
            percentChange: '0',
            iconUrl: ''),
      ];
      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<CryptoLoading>(),
          isA<CryptoLoaded>().having(
              (s) => (s as CryptoLoaded).cryptos.length, 'cryptos.length', 1),
        ]),
      );
      await cubit.fetchCryptos();
    });

    test('emite loading e error ao falhar', () async {
      mockRepo.throwError = true;
      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<CryptoLoading>(),
          isA<CryptoError>(),
        ]),
      );
      await cubit.fetchCryptos();
    });
  });
}
