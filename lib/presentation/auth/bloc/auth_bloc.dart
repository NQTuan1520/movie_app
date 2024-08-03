import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/auth/usecase/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc(
    this.authUseCase,
  ) : super(AuthInitial()) {
    on<AuthRegister>(_onRegister);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
    on<AuthCheckStatus>(_onCheckStatus);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<SignInAnonymouslyEvent>(_onSignInAnonymously);
    on<UpdateUsernameEvent>(_updateUsernameEvent);
    on<GetInformationEvent>(_getInformationEvent);
    on<UpdateImageEvent>(_updateImageEvent);
    on<ForgotPasswordEvent>(_forgotPasswordEvent);
    // Check current user status on app start
    add(AuthCheckStatus());
  }

  Future<void> _forgotPasswordEvent(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(ResetPasswordLoading());
    try {
      await authUseCase.forgotPassword(event.email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }

  Future<void> _updateImageEvent(UpdateImageEvent event, Emitter<AuthState> emit) async {
    emit(UpdateImageProfileLoading());
    try {
      final user = await authUseCase.updateImage(event.image);
      emit(UpdateImageProfileSuccess(user));
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(UpdateImageProfileFailure(e.toString()));
    }
  }

  Future<void> _getInformationEvent(GetInformationEvent event, Emitter<AuthState> emit) async {
    emit(GetInformationLoading());
    try {
      final user = await authUseCase.getCurrentUser();
      emit(GetInformationSuccess(user!));
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInAnonymously(SignInAnonymouslyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authUseCase.signInAnonymously();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(LoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authUseCase.loginWithGoogle();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authUseCase.register(event.email, event.username, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthRegisterFailure(e.toString()));
    }
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authUseCase.login(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      await authUseCase.logout();

      emit(AuthUnauthenticated());
      // context.read<FavouriteBloc>().add(ResetFavourites());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    try {
      final user = await authUseCase.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _updateUsernameEvent(UpdateUsernameEvent event, Emitter<AuthState> emit) async {
    emit(AuthUpdateUsernameLoading());
    try {
      final user = await authUseCase.updateProfile(event.username);
      emit(AuthUpdateUsernameSuccess(user));
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUpdateUsernameFailure(e.toString()));
    }
  }
}
