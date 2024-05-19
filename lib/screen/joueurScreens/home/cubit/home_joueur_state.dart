part of 'home_joueur_cubit.dart';

@immutable
sealed class HomeJoueurState {}

final class HomeJoueurInitial extends HomeJoueurState {}

final class ResetHomeState extends HomeJoueurState {}

final class ChangeIndexNavBarState extends HomeJoueurState {}

final class UpdateJoueurModelVariable extends HomeJoueurState {}

final class GetMyInformationLoading extends HomeJoueurState {}

final class ErrorHomeState extends HomeJoueurState {
  final ErrorModel model;
  ErrorHomeState({required this.model});
}

final class GetMyInformationStateGood extends HomeJoueurState {
  final DataJoueurModel model;
  GetMyInformationStateGood({required this.model});
}

final class GetMyInformationStateBad extends HomeJoueurState {}
