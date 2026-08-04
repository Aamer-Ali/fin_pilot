import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched once at app start to check for a stored session.
class AppStarted extends AuthEvent {
  const AppStarted();
}

class LoginRequested extends AuthEvent {
  const LoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignupRequested extends AuthEvent {
  const SignupRequested({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });

  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}

class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

class AppleSignInRequested extends AuthEvent {
  const AppleSignInRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
