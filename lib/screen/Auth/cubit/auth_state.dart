part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class PasswordHiddenState extends AuthState {}

final class CheckBoxState extends AuthState {}

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

// --------------------------------------------
class PasswordRecoveryInitial extends AuthState {}

class PasswordRecoveryLoading extends AuthState {}

final class PasswordRecoverySuccess extends AuthState {
  final bool isresnd;

  PasswordRecoverySuccess({required this.isresnd});
}

final class PasswordRecoveryFailure extends AuthState {
  final ErrorModel errorModel;

  PasswordRecoveryFailure({required this.errorModel});
}

class PasswordRecoveryBad extends AuthState {}

//----
class PasswordResetLoading extends AuthState {}

class PasswordResetSuccess extends AuthState {}

final class PasswordResetFailure extends AuthState {
  final ErrorModel errorModel;

  PasswordResetFailure({required this.errorModel});
}

class PasswordResetBad extends AuthState {}
//----------------------

class VerifyCodeSuccess extends AuthState {}

final class VerifyCodeFailure extends AuthState {
  final ErrorModel errorModel;

  VerifyCodeFailure({required this.errorModel});
}

class VerifyCodeBad extends AuthState {}

//-----------

final class PasswordVisibilityChanged extends AuthState {}
