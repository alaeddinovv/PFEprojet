part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class PasswordHiddenState extends AuthState {}

// register------------------------------------------

final class RegisterLodinState extends AuthState {}

final class RegisterStateGood extends AuthState {
  final dynamic model;

  RegisterStateGood({required this.model});
}

final class ErrorState extends AuthState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class RegisterStateBad extends AuthState {}

// login---------------------------------

final class LoginLoadingState extends AuthState {}

final class LoginStateGood extends AuthState {
  final dynamic model;

  LoginStateGood({required this.model});
}

final class LoginStateBad extends AuthState {}
