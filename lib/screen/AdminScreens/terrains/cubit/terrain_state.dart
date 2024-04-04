part of 'terrain_cubit.dart';

@immutable
abstract class TerrainState {}

class TerrainInitial extends TerrainState {}

class GetMyTerrainsLoading extends TerrainState {}

class GetMyTerrainsStateGood extends TerrainState {}

class GetMyTerrainsStateBad extends TerrainState {}

final class ErrorTerrainsState extends TerrainState {
  final ErrorModel errorModel;

  ErrorTerrainsState({required this.errorModel});
}

class TerrainSlideChanged extends TerrainState {}

class TerrainViewToggled extends TerrainState {}

class TerrainDateChangedState extends TerrainState {}

class AddNonReservableTimeBlockState extends TerrainState {}

class DublicatedAddNonReservableTimeBlockState extends TerrainState {}

class SelectedDayChangedState extends TerrainState {
  final String? selctedDay;

  SelectedDayChangedState({required this.selctedDay});
}

class RemoveNonReservableTimeBlockState extends TerrainState {}

class EditingNonReservableTimeBlock extends TerrainState {
  final int? index;

  EditingNonReservableTimeBlock({required this.index});
}

class LoadinCheckUserByIdState extends TerrainState {}

class CheckUserByIdStateGood extends TerrainState {
  final DataJoueurModel dataJoueurModel;

  CheckUserByIdStateGood({required this.dataJoueurModel});
}

class CheckUserByIdStateBad extends TerrainState {}

final class ErrorState extends TerrainState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}
