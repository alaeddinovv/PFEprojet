part of 'reservation_cubit.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

final class ResetValueReservationState extends ReservationState {}

final class ErrorState extends ReservationState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class GetReservationLoadingState extends ReservationState {}

final class GetReservationStateGood extends ReservationState {}

final class GetReservationStateBad extends ReservationState {}

//-------------------------------------------------ReservationDetailsScreen--------------------------------
final class AddReservationLoadingState extends ReservationState {}

final class AddReservationStateGood extends ReservationState {}

final class AddReservationStateBad extends ReservationState {}

final class DeleteReservationLoadingState extends ReservationState {}

final class DeleteReservationStateGood extends ReservationState {}

final class DeleteReservationStateBad extends ReservationState {}
