import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import 'auth_repository_impl.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User> fetchUserMe() async {
    try {
      final dio = await AuthRepositoryImpl.dioWithAuth();
      final response = await dio.get('/api/user/me');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao buscar dados do usuário: $e');
    }
  }

  @override
  Future<User> updateUserMe(
      {String? nome, String? descricao, String? imagem}) async {
    try {
      final dio = await AuthRepositoryImpl.dioWithAuth();
      final response = await dio.put(
        '/api/user/me',
        data: {
          if (nome != null) 'nome': nome,
          if (descricao != null) 'descricao': descricao,
          if (imagem != null) 'imagem': imagem,
        },
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao atualizar dados do usuário: $e');
    }
  }
}
