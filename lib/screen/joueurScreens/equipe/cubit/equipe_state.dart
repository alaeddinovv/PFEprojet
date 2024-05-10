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


final class GetEquipeImInLoading extends EquipeState {}

final class GetEquipeImInStateGood extends EquipeState {}

final class GetEquipeImInStateBad extends EquipeState {}


final class GetEquipeInviteLoading extends EquipeState {}

final class GetEquipeInviteStateGood extends EquipeState {}

final class GetEquipeInviteStateBad extends EquipeState {}


final class AccepterInvLoadingState extends EquipeState {}

final class AccepterInvStateGood extends EquipeState {
  final String joueurname;
  final String joueurId;
  AccepterInvStateGood({required this.joueurname,required this.joueurId});
}

final class AccepterInvStateBad extends EquipeState {}


final class RefuserInvLoadingState extends EquipeState {}

final class RefuserInvStateGood extends EquipeState {}

final class RefuserInvStateBad extends EquipeState {}


final class DemandeRejoindreEquipeLoadingState extends EquipeState {}

final class DemandeRejoindreEquipeStateGood extends EquipeState {}

final class DemandeRejoindreEquipeInvStateBad extends EquipeState {}


final class AnnulerRejoindreEquipeLoadingState extends EquipeState {}

final class AnnulerRejoindreEquipeStateGood extends EquipeState {}

final class AnnulerRejoindreEquipeInvStateBad extends EquipeState {}


final class CapitaineAceeptJoueurLoadingState extends EquipeState {}

final class CapitaineAceeptJoueurStateGood extends EquipeState {
  final String equipename;
  final String joueurId;
  CapitaineAceeptJoueurStateGood({required this.equipename,required this.joueurId});
}

final class CapitaineAceeptJoueurStateBad extends EquipeState {}



final class CapitaineRefuseJoueurLoadingState extends EquipeState {}

final class CapitaineRefuseJoueurStateGood extends EquipeState {
  final String idJoueur;

  CapitaineRefuseJoueurStateGood({required this.idJoueur});
}

final class CapitaineRefuseJoueurStateBad extends EquipeState {}



final class CapitaineInviteJoueurLoadingState extends EquipeState {}

final class CapitaineInviteJoueurStateGood extends EquipeState {
  final String equipename;
  final String joueurId;

  CapitaineInviteJoueurStateGood({required this.equipename,required this.joueurId});
}

final class CapitaineInviteJoueurStateBad extends EquipeState {}



final class CapitaineAnnuleInvitationJoueurLoadingState extends EquipeState {}

final class CapitaineAnnuleInvitationJoueurStateGood extends EquipeState {

  final String idJoueur;

  CapitaineAnnuleInvitationJoueurStateGood({required this.idJoueur});
}

final class CapitaineAnnuleInvitationJoueurStateBad extends EquipeState {}



final class QuiterEquipeLoadingState extends EquipeState {}

final class QuiterEquipeStateGood extends EquipeState {
  final String idJoueur;

  QuiterEquipeStateGood({required this.idJoueur});
}

final class QuiterEquipeStateBad extends EquipeState {}





class LoadinCheckUserByUsernameState extends EquipeState {}

class CheckUserByUsernameStateGood extends EquipeState {
  final DataJoueurModel dataJoueurModel;

  CheckUserByUsernameStateGood({required this.dataJoueurModel});
}

class CheckUserByUsernameStateBad extends EquipeState {}
