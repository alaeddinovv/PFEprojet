part of 'reservation_cubit.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

final class ErrorState extends ReservationState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class GetReservationLoadingState extends ReservationState {}

final class GetReservationStateGood extends ReservationState {}

final class GetReservationStateBad extends ReservationState {}
