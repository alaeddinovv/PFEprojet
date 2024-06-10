// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `select Day`
  String get selectday {
    return Intl.message(
      'select Day',
      name: 'selectday',
      desc: '',
      args: [],
    );
  }

  /// `select Hour`
  String get selecthour {
    return Intl.message(
      'select Hour',
      name: 'selecthour',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'annonce.dart' key

  /// `Mes annonces`
  String get my_annonces {
    return Intl.message(
      'Mes annonces',
      name: 'my_annonces',
      desc: '',
      args: [],
    );
  }

  /// `Toutes les annonces`
  String get all_annonces {
    return Intl.message(
      'Toutes les annonces',
      name: 'all_annonces',
      desc: '',
      args: [],
    );
  }

  /// `Échec de la récupération des données`
  String get failed_to_fetch_data {
    return Intl.message(
      'Échec de la récupération des données',
      name: 'failed_to_fetch_data',
      desc: '',
      args: [],
    );
  }

  /// `Aucun numéro de téléphone disponible.`
  String get no_telephone_number_available {
    return Intl.message(
      'Aucun numéro de téléphone disponible.',
      name: 'no_telephone_number_available',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer l'annonce`
  String get delete_annonce {
    return Intl.message(
      'Supprimer l\'annonce',
      name: 'delete_annonce',
      desc: '',
      args: [],
    );
  }

  /// `Êtes-vous sûr de vouloir supprimer cette annonce?`
  String get are_you_sure_you_want_to_delete_this_annonce {
    return Intl.message(
      'Êtes-vous sûr de vouloir supprimer cette annonce?',
      name: 'are_you_sure_you_want_to_delete_this_annonce',
      desc: '',
      args: [],
    );
  }

  /// `Oui`
  String get yes {
    return Intl.message(
      'Oui',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Non`
  String get no {
    return Intl.message(
      'Non',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'addAnnonce.dart' key

  /// `Ajouter une Annonce`
  String get add_annonce {
    return Intl.message(
      'Ajouter une Annonce',
      name: 'add_annonce',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `search joueur`
  String get search_joueur {
    return Intl.message(
      'search joueur',
      name: 'search_joueur',
      desc: '',
      args: [],
    );
  }

  /// `search join equipe`
  String get search_join_equipe {
    return Intl.message(
      'search join equipe',
      name: 'search_join_equipe',
      desc: '',
      args: [],
    );
  }

  /// `Autre`
  String get other {
    return Intl.message(
      'Autre',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Nom du terrain`
  String get terrain_name {
    return Intl.message(
      'Nom du terrain',
      name: 'terrain_name',
      desc: '',
      args: [],
    );
  }

  /// `Heure de début`
  String get start_time {
    return Intl.message(
      'Heure de début',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Équipe sélectionnée`
  String get selected_equipe {
    return Intl.message(
      'Équipe sélectionnée',
      name: 'selected_equipe',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de joueurs`
  String get number_of_players {
    return Intl.message(
      'Nombre de joueurs',
      name: 'number_of_players',
      desc: '',
      args: [],
    );
  }

  /// `Le nombre de joueurs ne peut pas dépasser 5`
  String get number_of_players_error {
    return Intl.message(
      'Le nombre de joueurs ne peut pas dépasser 5',
      name: 'number_of_players_error',
      desc: '',
      args: [],
    );
  }

  /// `Poste pour le joueur`
  String get position_for_player {
    return Intl.message(
      'Poste pour le joueur',
      name: 'position_for_player',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Annonce publiée avec succès`
  String get annonce_published_success {
    return Intl.message(
      'Annonce publiée avec succès',
      name: 'annonce_published_success',
      desc: '',
      args: [],
    );
  }

  /// `Le serveur a planté`
  String get server_crashed {
    return Intl.message(
      'Le serveur a planté',
      name: 'server_crashed',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez remplir tous les champs requis`
  String get fill_all_fields {
    return Intl.message(
      'Veuillez remplir tous les champs requis',
      name: 'fill_all_fields',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez sélectionner une heure`
  String get select_time_error {
    return Intl.message(
      'Veuillez sélectionner une heure',
      name: 'select_time_error',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez sélectionner`
  String get select {
    return Intl.message(
      'Veuillez sélectionner',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez entrer`
  String get enter {
    return Intl.message(
      'Veuillez entrer',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'profile.dart.dart(joueur)' key

  /// `Profil`
  String get profile {
    return Intl.message(
      'Profil',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Nom d'utilisateur`
  String get username {
    return Intl.message(
      'Nom d\'utilisateur',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Nom`
  String get nom {
    return Intl.message(
      'Nom',
      name: 'nom',
      desc: '',
      args: [],
    );
  }

  /// `Prénom`
  String get prenom {
    return Intl.message(
      'Prénom',
      name: 'prenom',
      desc: '',
      args: [],
    );
  }

  /// `Wilaya`
  String get wilaya {
    return Intl.message(
      'Wilaya',
      name: 'wilaya',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get email {
    return Intl.message(
      'E-Mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone`
  String get phone {
    return Intl.message(
      'Téléphone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Déconnecté`
  String get disconnect {
    return Intl.message(
      'Déconnecté',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Changer la langue`
  String get change_language {
    return Intl.message(
      'Changer la langue',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Nom d'utilisateur copié avec succès`
  String get copy_username_success {
    return Intl.message(
      'Nom d\'utilisateur copié avec succès',
      name: 'copy_username_success',
      desc: '',
      args: [],
    );
  }

  /// `Modifier le profil`
  String get modify_profile {
    return Intl.message(
      'Modifier le profil',
      name: 'modify_profile',
      desc: '',
      args: [],
    );
  }

  /// `Modifier le mot de passe`
  String get modify_password {
    return Intl.message(
      'Modifier le mot de passe',
      name: 'modify_password',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'deatilsTerrian.dart.dart(joueur)' key

  /// `Réservation`
  String get reservation {
    return Intl.message(
      'Réservation',
      name: 'reservation',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de joueurs`
  String get player_count {
    return Intl.message(
      'Nombre de joueurs',
      name: 'player_count',
      desc: '',
      args: [],
    );
  }

  /// `joueurs`
  String get players {
    return Intl.message(
      'joueurs',
      name: 'players',
      desc: '',
      args: [],
    );
  }

  /// `État du terrain`
  String get terrain_state {
    return Intl.message(
      'État du terrain',
      name: 'terrain_state',
      desc: '',
      args: [],
    );
  }

  /// `Plus`
  String get more {
    return Intl.message(
      'Plus',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'UpdateProfile.dart.dart(joueur)' key

  /// `Mettre à jour`
  String get update {
    return Intl.message(
      'Mettre à jour',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Le nom d'utilisateur ne doit pas être vide`
  String get usernameMustNotBeEmpty {
    return Intl.message(
      'Le nom d\'utilisateur ne doit pas être vide',
      name: 'usernameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Nom :`
  String get name {
    return Intl.message(
      'Nom :',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Le nom ne doit pas être vide`
  String get nameMustNotBeEmpty {
    return Intl.message(
      'Le nom ne doit pas être vide',
      name: 'nameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Le prénom ne doit pas être vide`
  String get prenomMustNotBeEmpty {
    return Intl.message(
      'Le prénom ne doit pas être vide',
      name: 'prenomMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone`
  String get telephone {
    return Intl.message(
      'Téléphone',
      name: 'telephone',
      desc: '',
      args: [],
    );
  }

  /// `Le téléphone ne doit pas être vide`
  String get phoneMustNotBeEmpty {
    return Intl.message(
      'Le téléphone ne doit pas être vide',
      name: 'phoneMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Âge`
  String get age {
    return Intl.message(
      'Âge',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `L'âge ne doit pas être vide`
  String get ageMustNotBeEmpty {
    return Intl.message(
      'L\'âge ne doit pas être vide',
      name: 'ageMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Poste`
  String get poste {
    return Intl.message(
      'Poste',
      name: 'poste',
      desc: '',
      args: [],
    );
  }

  /// `Le poste ne doit pas être vide`
  String get posteMustNotBeEmpty {
    return Intl.message(
      'Le poste ne doit pas être vide',
      name: 'posteMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Succès`
  String get success {
    return Intl.message(
      'Succès',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Choisissez la source :`
  String get chooseSource {
    return Intl.message(
      'Choisissez la source :',
      name: 'chooseSource',
      desc: '',
      args: [],
    );
  }

  /// `Caméra`
  String get camera {
    return Intl.message(
      'Caméra',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Galerie`
  String get gallery {
    return Intl.message(
      'Galerie',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'EditeReserve.dart(joueur)' key

  /// `Modifier la réservation`
  String get appBarTitle {
    return Intl.message(
      'Modifier la réservation',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Détails de la réservation`
  String get reservationDetails {
    return Intl.message(
      'Détails de la réservation',
      name: 'reservationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Heure`
  String get time {
    return Intl.message(
      'Heure',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `semaine(s)`
  String get weeks {
    return Intl.message(
      'semaine(s)',
      name: 'weeks',
      desc: '',
      args: [],
    );
  }

  /// `Votre équipe`
  String get yourTeam {
    return Intl.message(
      'Votre équipe',
      name: 'yourTeam',
      desc: '',
      args: [],
    );
  }

  /// `Pas d'équipe`
  String get noTeam {
    return Intl.message(
      'Pas d\'équipe',
      name: 'noTeam',
      desc: '',
      args: [],
    );
  }

  /// `changer l'équipe`
  String get changeTeam {
    return Intl.message(
      'changer l\'équipe',
      name: 'changeTeam',
      desc: '',
      args: [],
    );
  }

  /// `pour toutes les réservations`
  String get forAllReservations {
    return Intl.message(
      'pour toutes les réservations',
      name: 'forAllReservations',
      desc: '',
      args: [],
    );
  }

  /// `pour cette réservation uniquement`
  String get forThisReservationOnly {
    return Intl.message(
      'pour cette réservation uniquement',
      name: 'forThisReservationOnly',
      desc: '',
      args: [],
    );
  }

  /// `retirer l'équipe`
  String get removeTeam {
    return Intl.message(
      'retirer l\'équipe',
      name: 'removeTeam',
      desc: '',
      args: [],
    );
  }

  /// `Êtes-vous sûr de vouloir retirer votre équipe de cette réservation ?`
  String get removeTeamConfirmation {
    return Intl.message(
      'Êtes-vous sûr de vouloir retirer votre équipe de cette réservation ?',
      name: 'removeTeamConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `vous n'avez pas encore d'équipe`
  String get youDontHaveTeamYet {
    return Intl.message(
      'vous n\'avez pas encore d\'équipe',
      name: 'youDontHaveTeamYet',
      desc: '',
      args: [],
    );
  }

  /// `Pas encore assigné`
  String get notAssignedYet {
    return Intl.message(
      'Pas encore assigné',
      name: 'notAssignedYet',
      desc: '',
      args: [],
    );
  }

  /// `Équipe adverse`
  String get opponentsTeam {
    return Intl.message(
      'Équipe adverse',
      name: 'opponentsTeam',
      desc: '',
      args: [],
    );
  }

  /// `choisir :`
  String get choose {
    return Intl.message(
      'choisir :',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Pas encore d'équipe adverse`
  String get noOpponentTeamYet {
    return Intl.message(
      'Pas encore d\'équipe adverse',
      name: 'noOpponentTeamYet',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer la connexion`
  String get confirmConnection {
    return Intl.message(
      'Confirmer la connexion',
      name: 'confirmConnection',
      desc: '',
      args: [],
    );
  }

  /// `aucun changement détecté`
  String get noChangesDetected {
    return Intl.message(
      'aucun changement détecté',
      name: 'noChangesDetected',
      desc: '',
      args: [],
    );
  }

  /// `Détails du joueur`
  String get joueurDetails {
    return Intl.message(
      'Détails du joueur',
      name: 'joueurDetails',
      desc: '',
      args: [],
    );
  }

  /// `Accueil`
  String get home {
    return Intl.message(
      'Accueil',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Français`
  String get french {
    return Intl.message(
      'Français',
      name: 'french',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get arabic {
    return Intl.message(
      'العربية',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Se déconnecter`
  String get logout {
    return Intl.message(
      'Se déconnecter',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Nous contacter`
  String get contact_us {
    return Intl.message(
      'Nous contacter',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Ancien mot de passe`
  String get old_password {
    return Intl.message(
      'Ancien mot de passe',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `Le mot de passe ne doit pas être vide`
  String get password_cannot_be_empty {
    return Intl.message(
      'Le mot de passe ne doit pas être vide',
      name: 'password_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Nouveau mot de passe`
  String get new_password {
    return Intl.message(
      'Nouveau mot de passe',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Les mots de passe ne correspondent pas`
  String get passwords_do_not_match {
    return Intl.message(
      'Les mots de passe ne correspondent pas',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer le nouveau mot de passe`
  String get confirm_new_password {
    return Intl.message(
      'Confirmer le nouveau mot de passe',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe modifié avec succès`
  String get password_updated_successfully {
    return Intl.message(
      'Mot de passe modifié avec succès',
      name: 'password_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Erreur du serveur`
  String get server_error {
    return Intl.message(
      'Erreur du serveur',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `Le nom ne doit pas être vide`
  String get name_cannot_be_empty {
    return Intl.message(
      'Le nom ne doit pas être vide',
      name: 'name_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Prénom :`
  String get surname {
    return Intl.message(
      'Prénom :',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Le prénom ne doit pas être vide`
  String get surname_cannot_be_empty {
    return Intl.message(
      'Le prénom ne doit pas être vide',
      name: 'surname_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Sélectionnez une wilaya`
  String get select_wilaya {
    return Intl.message(
      'Sélectionnez une wilaya',
      name: 'select_wilaya',
      desc: '',
      args: [],
    );
  }

  /// `Le téléphone ne doit pas être vide`
  String get phone_cannot_be_empty {
    return Intl.message(
      'Le téléphone ne doit pas être vide',
      name: 'phone_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Choisissez la source :`
  String get choose_source {
    return Intl.message(
      'Choisissez la source :',
      name: 'choose_source',
      desc: '',
      args: [],
    );
  }

  /// `Terrains`
  String get fields {
    return Intl.message(
      'Terrains',
      name: 'fields',
      desc: '',
      args: [],
    );
  }

  /// `Réservations`
  String get reservations {
    return Intl.message(
      'Réservations',
      name: 'reservations',
      desc: '',
      args: [],
    );
  }

  /// `Annonces`
  String get announcements {
    return Intl.message(
      'Annonces',
      name: 'announcements',
      desc: '',
      args: [],
    );
  }

  /// `Supprimé avec succès`
  String get deleted_successfully {
    return Intl.message(
      'Supprimé avec succès',
      name: 'deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Erreur lors de la suppression`
  String get error_deleting {
    return Intl.message(
      'Erreur lors de la suppression',
      name: 'error_deleting',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer le terrain`
  String get delete_terrain {
    return Intl.message(
      'Supprimer le terrain',
      name: 'delete_terrain',
      desc: '',
      args: [],
    );
  }

  /// `Êtes-vous sûr de vouloir supprimer ce terrain ?`
  String get delete_terrain_confirmation {
    return Intl.message(
      'Êtes-vous sûr de vouloir supprimer ce terrain ?',
      name: 'delete_terrain_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Annuler`
  String get cancel {
    return Intl.message(
      'Annuler',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer`
  String get delete {
    return Intl.message(
      'Supprimer',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Da/H`
  String get currency_da_per_hour {
    return Intl.message(
      'Da/H',
      name: 'currency_da_per_hour',
      desc: '',
      args: [],
    );
  }

  /// `Sélectionner un jour`
  String get select_a_day {
    return Intl.message(
      'Sélectionner un jour',
      name: 'select_a_day',
      desc: '',
      args: [],
    );
  }

  /// `Sélectionner une heure`
  String get select_a_time {
    return Intl.message(
      'Sélectionner une heure',
      name: 'select_a_time',
      desc: '',
      args: [],
    );
  }

  /// `Le nom du stade`
  String get stadium_name {
    return Intl.message(
      'Le nom du stade',
      name: 'stadium_name',
      desc: '',
      args: [],
    );
  }

  /// `Jour`
  String get day {
    return Intl.message(
      'Jour',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Stade`
  String get stadium {
    return Intl.message(
      'Stade',
      name: 'stadium',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer ce jour`
  String get delete_this_day {
    return Intl.message(
      'Supprimer ce jour',
      name: 'delete_this_day',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer cette heure`
  String get delete_this_time {
    return Intl.message(
      'Supprimer cette heure',
      name: 'delete_this_time',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer ce stade`
  String get delete_this_stadium {
    return Intl.message(
      'Supprimer ce stade',
      name: 'delete_this_stadium',
      desc: '',
      args: [],
    );
  }

  /// `à`
  String get at {
    return Intl.message(
      'à',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Durée`
  String get duration {
    return Intl.message(
      'Durée',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `État`
  String get status {
    return Intl.message(
      'État',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Détails de la réservation`
  String get reservation_details {
    return Intl.message(
      'Détails de la réservation',
      name: 'reservation_details',
      desc: '',
      args: [],
    );
  }

  /// `Terrain`
  String get field {
    return Intl.message(
      'Terrain',
      name: 'field',
      desc: '',
      args: [],
    );
  }

  /// `Ajouté avec succès`
  String get added_successfully {
    return Intl.message(
      'Ajouté avec succès',
      name: 'added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Acceptez votre réservation`
  String get reservation_accepted {
    return Intl.message(
      'Acceptez votre réservation',
      name: 'reservation_accepted',
      desc: '',
      args: [],
    );
  }

  /// `a accepté votre réservation pour le`
  String get reservation_accepted_for {
    return Intl.message(
      'a accepté votre réservation pour le',
      name: 'reservation_accepted_for',
      desc: '',
      args: [],
    );
  }

  /// `Erreur`
  String get error {
    return Intl.message(
      'Erreur',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Accepter`
  String get accept {
    return Intl.message(
      'Accepter',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Refuser votre réservation`
  String get reservation_declined {
    return Intl.message(
      'Refuser votre réservation',
      name: 'reservation_declined',
      desc: '',
      args: [],
    );
  }

  /// `a refusé votre réservation pour le`
  String get reservation_declined_for {
    return Intl.message(
      'a refusé votre réservation pour le',
      name: 'reservation_declined_for',
      desc: '',
      args: [],
    );
  }

  /// `Refuser`
  String get decline {
    return Intl.message(
      'Refuser',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer l'annonce`
  String get delete_announcement {
    return Intl.message(
      'Supprimer l\'annonce',
      name: 'delete_announcement',
      desc: '',
      args: [],
    );
  }

  /// `Êtes-vous sûr de vouloir supprimer cette annonce ?`
  String get delete_announcement_confirmation {
    return Intl.message(
      'Êtes-vous sûr de vouloir supprimer cette annonce ?',
      name: 'delete_announcement_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Détails de l'annonce`
  String get announcement_details {
    return Intl.message(
      'Détails de l\'annonce',
      name: 'announcement_details',
      desc: '',
      args: [],
    );
  }

  /// `Commune`
  String get commune {
    return Intl.message(
      'Commune',
      name: 'commune',
      desc: '',
      args: [],
    );
  }

  /// `Détails du propriétaire`
  String get owner_details {
    return Intl.message(
      'Détails du propriétaire',
      name: 'owner_details',
      desc: '',
      args: [],
    );
  }

  /// `date`
  String get announcement_timestamp {
    return Intl.message(
      'date',
      name: 'announcement_timestamp',
      desc: '',
      args: [],
    );
  }

  /// `Créé le`
  String get created_at {
    return Intl.message(
      'Créé le',
      name: 'created_at',
      desc: '',
      args: [],
    );
  }

  /// `Dernière mise à jour`
  String get last_update {
    return Intl.message(
      'Dernière mise à jour',
      name: 'last_update',
      desc: '',
      args: [],
    );
  }

  /// `Modifier l'annonce`
  String get edit_announcement {
    return Intl.message(
      'Modifier l\'annonce',
      name: 'edit_announcement',
      desc: '',
      args: [],
    );
  }

  /// `Concernant le timing`
  String get timing_related {
    return Intl.message(
      'Concernant le timing',
      name: 'timing_related',
      desc: '',
      args: [],
    );
  }

  /// `Perte de propriété`
  String get property_loss {
    return Intl.message(
      'Perte de propriété',
      name: 'property_loss',
      desc: '',
      args: [],
    );
  }

  /// `Le contenu ne doit pas être vide`
  String get content_cannot_be_empty {
    return Intl.message(
      'Le contenu ne doit pas être vide',
      name: 'content_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Contenu de l'annonce`
  String get announcement_content {
    return Intl.message(
      'Contenu de l\'annonce',
      name: 'announcement_content',
      desc: '',
      args: [],
    );
  }

  /// `Échec`
  String get failure {
    return Intl.message(
      'Échec',
      name: 'failure',
      desc: '',
      args: [],
    );
  }

  /// `Ajouter une annonce`
  String get add_announcement {
    return Intl.message(
      'Ajouter une annonce',
      name: 'add_announcement',
      desc: '',
      args: [],
    );
  }

  /// `Annonce publiée avec succès`
  String get announcement_published_successfully {
    return Intl.message(
      'Annonce publiée avec succès',
      name: 'announcement_published_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Publier l'annonce`
  String get publish_announcement {
    return Intl.message(
      'Publier l\'annonce',
      name: 'publish_announcement',
      desc: '',
      args: [],
    );
  }

  /// `Bienvenue,`
  String get welcome {
    return Intl.message(
      'Bienvenue,',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Découvrez des choix illimités et une commodité inégalée.`
  String get discover_unlimited_choices {
    return Intl.message(
      'Découvrez des choix illimités et une commodité inégalée.',
      name: 'discover_unlimited_choices',
      desc: '',
      args: [],
    );
  }

  /// `L'e-mail ne doit pas être vide`
  String get email_cannot_be_empty {
    return Intl.message(
      'L\'e-mail ne doit pas être vide',
      name: 'email_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get password {
    return Intl.message(
      'Mot de passe',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Responsable`
  String get responsible {
    return Intl.message(
      'Responsable',
      name: 'responsible',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe oublié ?`
  String get forgot_password {
    return Intl.message(
      'Mot de passe oublié ?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Bonjour {name}`
  String hello(Object name) {
    return Intl.message(
      'Bonjour $name',
      name: 'hello',
      desc: '',
      args: [name],
    );
  }

  /// `Se connecter`
  String get login {
    return Intl.message(
      'Se connecter',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Créer un compte`
  String get create_account {
    return Intl.message(
      'Créer un compte',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `À propos de nous`
  String get about_us {
    return Intl.message(
      'À propos de nous',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Demandes`
  String get requests {
    return Intl.message(
      'Demandes',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `Équipes`
  String get teams {
    return Intl.message(
      'Équipes',
      name: 'teams',
      desc: '',
      args: [],
    );
  }

  /// `Liste des terrains`
  String get list_terrain {
    return Intl.message(
      'Liste des terrains',
      name: 'list_terrain',
      desc: '',
      args: [],
    );
  }

  /// `Carte des terrains`
  String get map_terrain {
    return Intl.message(
      'Carte des terrains',
      name: 'map_terrain',
      desc: '',
      args: [],
    );
  }

  /// `Da/H`
  String get da_h {
    return Intl.message(
      'Da/H',
      name: 'da_h',
      desc: '',
      args: [],
    );
  }

  /// `Demande de réservation supprimée avec succès`
  String get delete_reservation_request_success {
    return Intl.message(
      'Demande de réservation supprimée avec succès',
      name: 'delete_reservation_request_success',
      desc: '',
      args: [],
    );
  }

  /// `Échec de la suppression de la demande de réservation`
  String get delete_reservation_request_failed {
    return Intl.message(
      'Échec de la suppression de la demande de réservation',
      name: 'delete_reservation_request_failed',
      desc: '',
      args: [],
    );
  }

  /// `Échec de la récupération des réservations`
  String get failed_to_fetch_reservations {
    return Intl.message(
      'Échec de la récupération des réservations',
      name: 'failed_to_fetch_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer la réservation`
  String get delete_reservation {
    return Intl.message(
      'Supprimer la réservation',
      name: 'delete_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Êtes-vous sûr de vouloir supprimer cette réservation ?`
  String get delete_reservation_confirmation {
    return Intl.message(
      'Êtes-vous sûr de vouloir supprimer cette réservation ?',
      name: 'delete_reservation_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Adresse`
  String get address {
    return Intl.message(
      'Adresse',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `État du terrain:`
  String get field_state {
    return Intl.message(
      'État du terrain:',
      name: 'field_state',
      desc: '',
      args: [],
    );
  }

  /// `Voir sur la carte`
  String get view_on_map {
    return Intl.message(
      'Voir sur la carte',
      name: 'view_on_map',
      desc: '',
      args: [],
    );
  }

  /// `Index des couleurs :`
  String get color_index {
    return Intl.message(
      'Index des couleurs :',
      name: 'color_index',
      desc: '',
      args: [],
    );
  }

  /// `Disponible pour réservation`
  String get available_for_reservation {
    return Intl.message(
      'Disponible pour réservation',
      name: 'available_for_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Bloqué par le propriétaire du stade`
  String get blocked_by_stadium_owner {
    return Intl.message(
      'Bloqué par le propriétaire du stade',
      name: 'blocked_by_stadium_owner',
      desc: '',
      args: [],
    );
  }

  /// `Réservé par d'autres joueurs`
  String get reserved_by_other_players {
    return Intl.message(
      'Réservé par d\'autres joueurs',
      name: 'reserved_by_other_players',
      desc: '',
      args: [],
    );
  }

  /// `Votre réservation approuvée`
  String get your_approved_reservation {
    return Intl.message(
      'Votre réservation approuvée',
      name: 'your_approved_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Votre réservation en attente`
  String get your_pending_reservation {
    return Intl.message(
      'Votre réservation en attente',
      name: 'your_pending_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Réserver`
  String get reserve {
    return Intl.message(
      'Réserver',
      name: 'reserve',
      desc: '',
      args: [],
    );
  }

  /// `Date de début`
  String get start_date {
    return Intl.message(
      'Date de début',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `Heure de début`
  String get start_hour {
    return Intl.message(
      'Heure de début',
      name: 'start_hour',
      desc: '',
      args: [],
    );
  }

  /// `Durée (en semaines)`
  String get duration_in_weeks {
    return Intl.message(
      'Durée (en semaines)',
      name: 'duration_in_weeks',
      desc: '',
      args: [],
    );
  }

  /// `Réservation ajoutée avec succès`
  String get reservation_added_successfully {
    return Intl.message(
      'Réservation ajoutée avec succès',
      name: 'reservation_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Erreur lors de l'ajout de la réservation`
  String get error_adding_reservation {
    return Intl.message(
      'Erreur lors de l\'ajout de la réservation',
      name: 'error_adding_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Terminé`
  String get done {
    return Intl.message(
      'Terminé',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Détails du terrain`
  String get terrain_details {
    return Intl.message(
      'Détails du terrain',
      name: 'terrain_details',
      desc: '',
      args: [],
    );
  }

  /// `Détails de l'équipe`
  String get team_details {
    return Intl.message(
      'Détails de l\'équipe',
      name: 'team_details',
      desc: '',
      args: [],
    );
  }

  /// `Nom de l'équipe`
  String get team_name {
    return Intl.message(
      'Nom de l\'équipe',
      name: 'team_name',
      desc: '',
      args: [],
    );
  }

  /// `Équipe inconnue`
  String get unknown_team {
    return Intl.message(
      'Équipe inconnue',
      name: 'unknown_team',
      desc: '',
      args: [],
    );
  }

  /// `Taille de l'équipe`
  String get team_size {
    return Intl.message(
      'Taille de l\'équipe',
      name: 'team_size',
      desc: '',
      args: [],
    );
  }

  /// `Capitaine`
  String get captain {
    return Intl.message(
      'Capitaine',
      name: 'captain',
      desc: '',
      args: [],
    );
  }

  /// `Joueurs en attente`
  String get pending_players {
    return Intl.message(
      'Joueurs en attente',
      name: 'pending_players',
      desc: '',
      args: [],
    );
  }

  /// `Emplacement`
  String get location {
    return Intl.message(
      'Emplacement',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Annuler la demande`
  String get cancel_request {
    return Intl.message(
      'Annuler la demande',
      name: 'cancel_request',
      desc: '',
      args: [],
    );
  }

  /// `Mes équipes`
  String get my_teams {
    return Intl.message(
      'Mes équipes',
      name: 'my_teams',
      desc: '',
      args: [],
    );
  }

  /// `Toutes les équipes`
  String get all_teams {
    return Intl.message(
      'Toutes les équipes',
      name: 'all_teams',
      desc: '',
      args: [],
    );
  }

  /// `Équipes où je suis`
  String get teams_im_in {
    return Intl.message(
      'Équipes où je suis',
      name: 'teams_im_in',
      desc: '',
      args: [],
    );
  }

  /// `Les invitations`
  String get invitations {
    return Intl.message(
      'Les invitations',
      name: 'invitations',
      desc: '',
      args: [],
    );
  }

  /// `Les équipes virtuelles :`
  String get virtual_teams {
    return Intl.message(
      'Les équipes virtuelles :',
      name: 'virtual_teams',
      desc: '',
      args: [],
    );
  }

  /// `Équipe`
  String get team {
    return Intl.message(
      'Équipe',
      name: 'team',
      desc: '',
      args: [],
    );
  }

  /// `État du terrain`
  String get field_condition {
    return Intl.message(
      'État du terrain',
      name: 'field_condition',
      desc: '',
      args: [],
    );
  }

  /// `MISE À JOUR DU TERRAIN`
  String get update_field {
    return Intl.message(
      'MISE À JOUR DU TERRAIN',
      name: 'update_field',
      desc: '',
      args: [],
    );
  }

  /// `Réservation supprimée avec succès`
  String get delete_reservation_successfully {
    return Intl.message(
      'Réservation supprimée avec succès',
      name: 'delete_reservation_successfully',
      desc: '',
      args: [],
    );
  }

  /// `L'utilisateur ne doit pas être vide`
  String get user_must_not_be_empty {
    return Intl.message(
      'L\'utilisateur ne doit pas être vide',
      name: 'user_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Supprimer la réservation`
  String get remove_reservation {
    return Intl.message(
      'Supprimer la réservation',
      name: 'remove_reservation',
      desc: '',
      args: [],
    );
  }

  /// `La durée ne doit pas être vide`
  String get duration_must_not_be_empty {
    return Intl.message(
      'La durée ne doit pas être vide',
      name: 'duration_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Rechercher des joueurs...`
  String get search_players {
    return Intl.message(
      'Rechercher des joueurs...',
      name: 'search_players',
      desc: '',
      args: [],
    );
  }

  /// `Poste`
  String get position {
    return Intl.message(
      'Poste',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `L'adresse ne doit pas être vide`
  String get address_must_not_be_empty {
    return Intl.message(
      'L\'adresse ne doit pas être vide',
      name: 'address_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `La description ne doit pas être vide`
  String get description_must_not_be_empty {
    return Intl.message(
      'La description ne doit pas être vide',
      name: 'description_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Largeur`
  String get width {
    return Intl.message(
      'Largeur',
      name: 'width',
      desc: '',
      args: [],
    );
  }

  /// `La largeur ne doit pas être vide`
  String get width_must_not_be_empty {
    return Intl.message(
      'La largeur ne doit pas être vide',
      name: 'width_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Longueur`
  String get length {
    return Intl.message(
      'Longueur',
      name: 'length',
      desc: '',
      args: [],
    );
  }

  /// `La longueur ne doit pas être vide`
  String get length_must_not_be_empty {
    return Intl.message(
      'La longueur ne doit pas être vide',
      name: 'length_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Prix`
  String get price {
    return Intl.message(
      'Prix',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Le prix ne doit pas être vide`
  String get price_must_not_be_empty {
    return Intl.message(
      'Le prix ne doit pas être vide',
      name: 'price_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Capacité`
  String get capacity {
    return Intl.message(
      'Capacité',
      name: 'capacity',
      desc: '',
      args: [],
    );
  }

  /// `La capacité ne doit pas être vide`
  String get capacity_must_not_be_empty {
    return Intl.message(
      'La capacité ne doit pas être vide',
      name: 'capacity_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `État`
  String get state {
    return Intl.message(
      'État',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `L'état ne doit pas être vide`
  String get state_must_not_be_empty {
    return Intl.message(
      'L\'état ne doit pas être vide',
      name: 'state_must_not_be_empty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
