part of 'home_admin_cubit.dart';

@immutable
sealed class HomeAdminState {}

final class HomeAdminInitial extends HomeAdminState {}

final class ChangeIndexNavBarState extends HomeAdminState {}

final class UpdateAdminModelVariable extends HomeAdminState {}

final class GetMyInformationLoading extends HomeAdminState {}

final class ErrorHomeState extends HomeAdminState {
  final ErrorModel model;
  ErrorHomeState({required this.model});
}

final class GetMyInformationStateGood extends HomeAdminState {
  final DataAdminModel model;
  GetMyInformationStateGood({required this.model});
}

final class GetMyInformationStateBad extends HomeAdminState {}
