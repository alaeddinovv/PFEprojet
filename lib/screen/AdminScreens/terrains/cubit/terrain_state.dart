part of 'terrain_cubit.dart';

@immutable
abstract class TerrainState {}

class TerrainInitial extends TerrainState {}

class TerrainSlideChanged extends TerrainState {}

class TerrainViewToggled extends TerrainState {}

class TerrainDateChanged extends TerrainState {}

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
