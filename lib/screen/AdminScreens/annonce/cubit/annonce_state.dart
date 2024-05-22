part of 'annonce_cubit.dart';

@immutable
abstract class AnnonceState {}

class AnnonceInitial extends AnnonceState {}

final class CreerAnnonceLoadingState extends AnnonceState {}

final class ResetValueAnnonceState extends AnnonceState {}

final class CreerAnnonceStateGood extends AnnonceState {}

final class CreerAnnonceStateBad extends AnnonceState {}

final class ErrorState extends AnnonceState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class DeleteAnnonceLoadingState extends AnnonceState {}

final class DeleteAnnonceStateGood extends AnnonceState {}

final class DeleteAnnonceStateBad extends AnnonceState {}

final class UpdateAnnonceLoadingState extends AnnonceState {}

final class UpdateAnnonceStateGood extends AnnonceState {}

final class UpdateAnnonceStateBad extends AnnonceState {}

final class GetMyAnnonceLoading extends AnnonceState {}

class GetMyAnnonceStateGood extends AnnonceState {}

final class GetMyAnnonceStateBad extends AnnonceState {}
