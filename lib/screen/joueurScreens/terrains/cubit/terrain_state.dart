part of 'terrain_cubit.dart';

@immutable
sealed class TerrainState {}

final class TerrainInitial extends TerrainState {}

final class ResetTerrainState extends TerrainState {}

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

class LoadinCheckUserByIdState extends TerrainState {}

class CheckUserByIdStateGood extends TerrainState {
  final DataJoueurModel dataJoueurModel;

  CheckUserByIdStateGood({required this.dataJoueurModel});
}

class CheckUserByIdStateBad extends TerrainState {}

class AddReservationLoadingState extends TerrainState {}

class AddReservationStateGood extends TerrainState {
  final String houre;
  final String date;

  AddReservationStateGood({required this.houre, required this.date});
}

class AddReservationStateBad extends TerrainState {}

class GetSearchEquipeLoading extends TerrainState {}

class GetSearchEquipeStateGood extends TerrainState {}

class GetSearchEquipeStateBad extends TerrainState {}

class GetMyReserveLoading extends TerrainState {}

class GetMyReserveStateGood extends TerrainState {
  final ReservationModel reservations;
  GetMyReserveStateGood({required this.reservations});
}

class GetMyReserveStateBad extends TerrainState {}

class ConfirmConnectEquipeLoading extends TerrainState {}

class ConfirmConnectEquipeStateGood extends TerrainState {}

class ConfirmConnectEquipeStateBad extends TerrainState {}

class CreateEquipeVertialLoading extends TerrainState {}

class CreateEquipeVertialStateGood extends TerrainState {
  // final EquipeModelData equipeModelData;

  // CreateEquipeVertialStateGood({required this.equipeModelData});
}

class CreateEquipeVertialStateBad extends TerrainState {}

class DeleteDemandeReservationLoading extends TerrainState {}

class DeleteDemandeReservationStateGood extends TerrainState {}

class DeleteDemandeReservationStateBad extends TerrainState {}
