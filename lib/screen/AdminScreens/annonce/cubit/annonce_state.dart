part of 'annonce_cubit.dart';

@immutable
abstract class AnnonceState {}

class AnnonceInitial extends AnnonceState {}

final class CreerAnnonceLoadingState extends AnnonceState {}

final class CreerAnnonceStateGood extends AnnonceState {}

final class CreerAnnonceStateBad extends AnnonceState {}

final class ErrorState extends AnnonceState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}

final class DeleteAnnonceLoadingState extends AnnonceState {}

final class DeleteAnnonceStateGood extends AnnonceState {}

final class DeleteAnnonceStateBad extends AnnonceState {}

final class GetMyAnnonceLoading extends AnnonceState {}

final class GetMyAnnonceStateBad extends AnnonceState {}

final class ErrorAnnonceState extends AnnonceState {
  final ErrorModel model;
  ErrorAnnonceState({required this.model});
}

class GetMyAnnonceStateGood extends AnnonceState {
  final List<AnnonceModel> annonces;
  GetMyAnnonceStateGood({required this.annonces});
}
