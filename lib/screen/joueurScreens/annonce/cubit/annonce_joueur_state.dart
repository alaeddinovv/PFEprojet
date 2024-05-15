part of 'annonce_joueur_cubit.dart';

@immutable
abstract class AnnonceJoueurState {}

class AnnonceJoueurInitial extends AnnonceJoueurState {}

final class CreerAnnonceJoueurLoadingState extends AnnonceJoueurState {}

final class CreerAnnonceJoueurStateGood extends AnnonceJoueurState {}

final class CreerAnnonceJoueurStateBad extends AnnonceJoueurState {}

final class ErrorStateAnnonce extends AnnonceJoueurState {
  final ErrorModel errorModel;

  ErrorStateAnnonce({required this.errorModel});
}

final class DeleteAnnonceJoueurLoadingState extends AnnonceJoueurState {}

final class DeleteAnnonceJoueurStateGood extends AnnonceJoueurState {}

final class DeleteAnnonceJoueurStateBad extends AnnonceJoueurState {}

final class UpdateAnnonceJoueurLoadingState extends AnnonceJoueurState {}

final class UpdateAnnonceJoueurStateGood extends AnnonceJoueurState {}

final class UpdateAnnonceJoueurStateBad extends AnnonceJoueurState {}

final class GetMyAnnonceJoueurLoading extends AnnonceJoueurState {}

final class GetMyAnnonceJoueurStateGood extends AnnonceJoueurState {}

final class GetMyAnnonceJoueurStateBad extends AnnonceJoueurState {}

final class GetAllAnnonceLoading extends AnnonceJoueurState {}

final class GetAllAnnonceStateGood extends AnnonceJoueurState {}

final class GetAllAnnonceStateBad extends AnnonceJoueurState {}

final class GetAnnonceByIDLoading extends AnnonceJoueurState {}

final class GetAnnonceByIDStateGood extends AnnonceJoueurState {
  final AnnonceSearchJoueurModel annonceSearchJoueurModel;

  GetAnnonceByIDStateGood({required this.annonceSearchJoueurModel});
}

final class GetAnnonceByIDStateBad extends AnnonceJoueurState {}
