part of 'terrain_cubit.dart';

@immutable
abstract class TerrainState {}

class TerrainInitial extends TerrainState {}

class ResetValueTerrainState extends TerrainState {}

final class ErrorTerrainsState extends TerrainState {
  final ErrorModel errorModel;

  ErrorTerrainsState({required this.errorModel});
}
//?---------------------------------------- TerrainHomeScreen-----------------------------------------------------------------

class GetMyTerrainsLoading extends TerrainState {}

class GetMyTerrainsStateGood extends TerrainState {}

class GetMyTerrainsStateBad extends TerrainState {}

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

class GetReservationJoueurInfoLoadingState extends TerrainState {}

class GetReservationJoueurInfoStateGood extends TerrainState {
  final List<ReservationModel> reservations;

  GetReservationJoueurInfoStateGood({required this.reservations});
}

class GetReservationJoueurInfoStateBad extends TerrainState {}

// ?-----------------------------------------Reserve.dart------------------------------------------
class LoadinCheckUserByIdState extends TerrainState {}

class CheckUserByIdStateGood extends TerrainState {
  final DataJoueurModel dataJoueurModel;

  CheckUserByIdStateGood({required this.dataJoueurModel});
}

class CheckUserByIdStateBad extends TerrainState {}

class AddReservationLoadingState extends TerrainState {}

class AddReservationStateGood extends TerrainState {}

class AddReservationStateBad extends TerrainState {}

//? ------------------------------Create_terrain.dart-------------------------------------------------
class RemoveNonReservableTimeBlockState extends TerrainState {}

class CreerTerrainLoadingState extends TerrainState {}

class CreerTerrainStateGood extends TerrainState {}

class CreerTerrainStateBad extends TerrainState {}

class UpdateTerrainLoadingState extends TerrainState {}

class UpdateTerrainStateGood extends TerrainState {
  final TerrainModel terrainModel;

  UpdateTerrainStateGood({required this.terrainModel});
}

class UpdateTerrainStateBad extends TerrainState {}

class DeleteTerrainLoadingState extends TerrainState {}

class DeleteTerrainStateGood extends TerrainState {}

class DeleteTerrainStateBad extends TerrainState {}

class EditingNonReservableTimeBlock extends TerrainState {
  final int? index;

  EditingNonReservableTimeBlock({required this.index});
}

class AddNonReservableTimeBlockState extends TerrainState {}

class DublicatedAddNonReservableTimeBlockState extends TerrainState {}

class PickImageState extends TerrainState {}

class RemoveImageState extends TerrainState {}

class DeleteTerrainImageLoadingState extends TerrainState {}

class DeleteTerrainImageStateGood extends TerrainState {}

class DeleteTerrainImageStateBad extends TerrainState {}

class SelectedDayChangedState extends TerrainState {
  final String? selctedDay;

  SelectedDayChangedState({required this.selctedDay});
}

class UploadTerrainImageAndAddUrlStateBad extends TerrainState {}

final class ErrorState extends TerrainState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

// ---------------------------------------ReservationPlayerInfo---------------------
class DeleteReservationLoadingState extends TerrainState {}

class DeleteReservationStateGood extends TerrainState {}

class DeleteReservationStateBad extends TerrainState {}
// ---------------------------------------SearchTest------------------------

class GetSearchJoueurLoading extends TerrainState {}

class GetSearchJoueurStateGood extends TerrainState {}

class GetSearchJoueurStateBad extends TerrainState {}

class GetJouerByUsernameLoading extends TerrainState {}

class GetJouerByUsernameStateGood extends TerrainState {
  final DataJoueurModel dataJoueurModel;

  GetJouerByUsernameStateGood({required this.dataJoueurModel});
}

class GetJouerByUsernameStateBad extends TerrainState {}
