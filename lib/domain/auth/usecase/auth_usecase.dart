import 'dart:typed_data';

import '../entity/user_entity.dart';
import '../repository/auth_reposiory.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<UserEntity> register(String email, String username, String password) {
    return repository.register(email, username, password);
  }

  Future<UserEntity> signInAnonymously() {
    return repository.signInAnonymously();
  }

  Future<UserEntity> loginWithGoogle() {
    return repository.loginWithGoogle();
  }

  Future<UserEntity> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<void> logout() {
    return repository.logout();
  }

  Future<UserEntity?> getCurrentUser() {
    return repository.getCurrentUser();
  }

  Future<UserEntity> updateProfile(String username) {
    return repository.updateProfile(username);
  }

  Future<UserEntity> updateImage(Uint8List imageBytes) {
    return repository.updateImage(imageBytes);
  }

  Future<void> forgotPassword(String email) {
    return repository.forgotPassword(email);
  }
}
