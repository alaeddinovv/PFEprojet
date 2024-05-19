part of 'reservation_cubit.dart';

@immutable
sealed class ReservationJoueurState {}

final class ReservationInitial extends ReservationJoueurState {}

final class ErrorState extends ReservationJoueurState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class GetAllEquipeDemanderLoading extends ReservationJoueurState {}

final class GetAllEquipeDemanderStateGood extends ReservationJoueurState {}

final class GetAllEquipeDemanderStateBad extends ReservationJoueurState {}
