part of 'terrain_cubit.dart';

@immutable
sealed class TerrainState {}

final class TerrainInitial extends TerrainState {}

final class ErrorState extends TerrainState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

//?---------------------------------------- TerrainHomeScreen-----------------------------------------------------------------

class GetMyTerrainsLoading extends TerrainState {}

class GetMyTerrainsStateGood extends TerrainState {}

class GetMyTerrainsStateBad extends TerrainState {}

final class ErrorTerrainsState extends TerrainState {
  final ErrorModel errorModel;

  ErrorTerrainsState({required this.errorModel});
}

//? -----------------------------------------Details.dart------------------------------------------
class TerrainSlideChanged extends TerrainState {}

class TerrainViewToggled extends TerrainState {}

class TerrainDateChangedState extends TerrainState {}

class GetReservationLoadingState extends TerrainState {}

class GetReservationStateGood extends TerrainState {
  final List<ReservationModel> reservations;

  GetReservationStateGood({required this.reservations});
}

class GetReservationStateBad extends TerrainState {}
