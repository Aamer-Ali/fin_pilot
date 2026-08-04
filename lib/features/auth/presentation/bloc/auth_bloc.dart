// Named constructor params intentionally read as `login:`/`signup:`/etc. at
// call sites rather than the private `_login:` an initializing formal would
// force.
// ignore_for_file: prefer_initializing_formals
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/auth/domain/usecases/check_auth_status.dart';
import 'package:fin_pilot/features/auth/domain/usecases/login.dart';
import 'package:fin_pilot/features/auth/domain/usecases/logout.dart';
import 'package:fin_pilot/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:fin_pilot/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:fin_pilot/features/auth/domain/usecases/signup.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_event.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CheckAuthStatusUseCase checkAuthStatus,
    required LoginUseCase login,
    required SignupUseCase signup,
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignInWithAppleUseCase signInWithApple,
    required LogoutUseCase logout,
  }) : _checkAuthStatus = checkAuthStatus,
       _login = login,
       _signup = signup,
       _signInWithGoogle = signInWithGoogle,
       _signInWithApple = signInWithApple,
       _logout = logout,
       super(const AuthState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<AppleSignInRequested>(_onAppleSignInRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final CheckAuthStatusUseCase _checkAuthStatus;
  final LoginUseCase _login;
  final SignupUseCase _signup;
  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignInWithAppleUseCase _signInWithApple;
  final LogoutUseCase _logout;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final result = await _checkAuthStatus(const NoParams());
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (hasSession) => emit(
        hasSession
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated(),
      ),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    _emitFromResult(result, emit);
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signup(
      SignupParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      ),
    );
    _emitFromResult(result, emit);
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signInWithGoogle(const NoParams());
    _emitFromResult(result, emit);
  }

  Future<void> _onAppleSignInRequested(
    AppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _signInWithApple(const NoParams());
    _emitFromResult(result, emit);
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logout(const NoParams());
    emit(const AuthState.unauthenticated());
  }

  void _emitFromResult(
    Either<Failure, Object?> result,
    Emitter<AuthState> emit,
  ) {
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.authenticated()),
    );
  }
}
