part of 'terrain_cubit.dart';

@immutable
abstract class TerrainState {}

class TerrainInitial extends TerrainState {}

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

class UpdateTerrainStateGood extends TerrainState {}

class UpdateTerrainStateBad extends TerrainState {}

class EditingNonReservableTimeBlock extends TerrainState {
  final int? index;

  EditingNonReservableTimeBlock({required this.index});
}

class AddNonReservableTimeBlockState extends TerrainState {}

class DublicatedAddNonReservableTimeBlockState extends TerrainState {}

class PickImageState extends TerrainState {}

class RemoveImageState extends TerrainState {}

class SelectedDayChangedState extends TerrainState {
  final String? selctedDay;

  SelectedDayChangedState({required this.selctedDay});
}

class UploadTerrainImageAndAddUrlStateBad extends TerrainState {}

final class ErrorState extends TerrainState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}
