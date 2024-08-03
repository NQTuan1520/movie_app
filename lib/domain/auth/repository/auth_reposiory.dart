import 'dart:typed_data';

import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> register(String email, String username, String password);
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> loginWithGoogle();
  Future<UserEntity> signInAnonymously();
  Future<UserEntity> updateProfile(String username);
  Future<UserEntity> updateImage(Uint8List image);
  Future<void> forgotPassword(String email);
}
