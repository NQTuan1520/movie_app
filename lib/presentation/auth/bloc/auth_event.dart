import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final String email;
  final String username;
  final String password;

  AuthRegister(
      {required this.email, required this.username, required this.password});

  @override
  List<Object> get props => [email, username, password];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthLogout extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

class LoginWithGoogleEvent extends AuthEvent {}

class SignInAnonymouslyEvent extends AuthEvent {}

class UpdateUsernameEvent extends AuthEvent {
  final String username;

  UpdateUsernameEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class GetInformationEvent extends AuthEvent {}

class UpdateImageEvent extends AuthEvent {
  final Uint8List image;

  UpdateImageEvent({required this.image});

  @override
  List<Object> get props => [image];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}