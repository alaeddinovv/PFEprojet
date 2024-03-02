part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class PasswordHiddenState extends AuthState {}

final class RegisterLodinState extends AuthState {}

final class RegisterStateGood extends AuthState {
  // final dynamic model;

  // RegisterStateGood({required this.model});
}

final class RegisterStateBad extends AuthState {
  // final dynamic model;

  // RegisterStateBad({required this.model});
}
