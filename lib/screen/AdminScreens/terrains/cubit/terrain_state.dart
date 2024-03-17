part of 'terrain_cubit.dart';

@immutable
abstract class TerrainState {}

class TerrainInitial extends TerrainState {}

class TerrainSlideChanged extends TerrainState {}

class TerrainViewToggled extends TerrainState {}

class TerrainDateChanged extends TerrainState {}
