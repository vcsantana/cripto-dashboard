import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/crypto.dart';
import '../../domain/repositories/crypto_repository.dart';

abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<Crypto> cryptos;
  CryptoLoaded(this.cryptos);
}

class CryptoError extends CryptoState {
  final String message;
  CryptoError(this.message);
}

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository repository;
  CryptoCubit(this.repository) : super(CryptoInitial());

  Future<void> fetchCryptos() async {
    emit(CryptoLoading());
    try {
      final cryptos = await repository.fetchCryptos();
      emit(CryptoLoaded(cryptos));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> searchCryptos(
      {String? nome, String? simbolo, String? tipo}) async {
    emit(CryptoLoading());
    try {
      final cryptos = await repository.searchCryptos(
          nome: nome, simbolo: simbolo, tipo: tipo);
      emit(CryptoLoaded(cryptos));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }
}
