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

  /// `other`
  String get other {
    return Intl.message(
      'other',
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

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
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

  /// `Nom`
  String get name {
    return Intl.message(
      'Nom',
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

  /// `semaines`
  String get weeks {
    return Intl.message(
      'semaines',
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

  /// `Erreur serveur`
  String get server_error {
    return Intl.message(
      'Erreur serveur',
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

  /// `Prénom`
  String get surname {
    return Intl.message(
      'Prénom',
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
