part of 'equipe_cubit.dart';

@immutable
abstract class EquipeState {}

class EquipeInitial extends EquipeState {}

final class CreerEquipeLoadingState extends EquipeState {}

final class CreerEquipeStateGood extends EquipeState {}

final class CreerEquipeStateBad extends EquipeState {}

final class ErrorState extends EquipeState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class DeleteEquipeLoadingState extends EquipeState {}

final class DeleteEquipeStateGood extends EquipeState {}

final class DeleteEquipeStateBad extends EquipeState {}

final class UpdateEquipeLoadingState extends EquipeState {}

final class UpdateEquipeStateGood extends EquipeState {}

final class UpdateEquipeStateBad extends EquipeState {}

final class GetMyEquipeLoading extends EquipeState {}

class GetMyEquipeStateGood extends EquipeState {}

final class GetMyEquipeStateBad extends EquipeState {}

final class GetAllEquipeLoading extends EquipeState {}

final class GetAllEquipeStateGood extends EquipeState {}

final class GetAllEquipeStateBad extends EquipeState {}
