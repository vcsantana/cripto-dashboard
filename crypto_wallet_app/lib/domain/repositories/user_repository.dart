import '../entities/user.dart';

abstract class UserRepository {
  Future<User> fetchUserMe();
  Future<User> updateUserMe({String? nome, String? descricao, String? imagem});
}
