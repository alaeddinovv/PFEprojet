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

  /// `Déconnexion`
  String get disconnect {
    return Intl.message(
      'Déconnexion',
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
