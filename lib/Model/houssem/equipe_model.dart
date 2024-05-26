import 'package:pfeprojet/Model/user_model.dart';

class EquipeModel {
  List<EquipeModelData>? data;
  bool? moreDataAvailable;
  String? nextCursor;

  EquipeModel({this.data, this.moreDataAvailable, this.nextCursor});

  EquipeModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List<dynamic>?)
        ?.map((e) => EquipeModelData.fromJson(e as Map<String, dynamic>))
        .toList();
    moreDataAvailable = json['moreDataAvailable'] as bool?;
    nextCursor = json['nextCursor'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data?.map((e) => e.toJson()).toList();
    data['moreDataAvailable'] = moreDataAvailable;
    data['nextCursor'] = nextCursor;
    return data;
  }
}

class EquipeModelData {
  String? id;
  String? nom;
  bool? vertial;
  int? numeroJoueurs;
  List<DataJoueurModel>? joueurs;
  List<DataJoueurModel>? attenteJoueurs;
  // List<dynamic>? attenteJoueurs;

  List<AttenteJoueursDemande>? attenteJoueursDemande;
  CapitaineId? capitaineId;
  List<dynamic>? tournois;
  String? wilaya;
  String? commune;
  String? createdAt;
  String? updatedAt;
  int? v;

  EquipeModelData({
    this.id,
    this.nom,
    this.vertial,
    this.numeroJoueurs,
    this.joueurs,
    this.attenteJoueurs,
    this.attenteJoueursDemande,
    this.capitaineId,
    this.tournois,
    this.wilaya,
    this.commune,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  EquipeModelData.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    nom = json['nom'] as String?;
    vertial = json['vertial'] as bool?;
    numeroJoueurs = json['numero_joueurs'] as int?;
    joueurs = (json['joueurs'] as List<dynamic>?)
        ?.map((e) => DataJoueurModel.fromJson(e as Map<String, dynamic>))
        .toList();
    attenteJoueurs = (json['attente_joueurs'] as List<dynamic>?)
        ?.map((e) => DataJoueurModel.fromJson(e as Map<String, dynamic>))
        .toList();
    // attenteJoueurs = json['attente_joueurs'] as List<dynamic>?;

    attenteJoueursDemande = (json['attente_joueurs_demande'] as List<dynamic>?)
        ?.map((e) => AttenteJoueursDemande.fromJson(e as Map<String, dynamic>))
        .toList();
    capitaineId = json['capitaine_id'] != null
        ? CapitaineId.fromJson(json['capitaine_id'] as Map<String, dynamic>)
        : null;
    tournois = json['tournois'] as List<dynamic>?;
    wilaya = json['wilaya'] as String?;
    commune = json['commune'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['nom'] = nom;
    data['vertial'] = vertial;
    data['numero_joueurs'] = numeroJoueurs;
    data['joueurs'] = joueurs?.map((e) => e.toJson()).toList();
    data['attente_joueurs'] = attenteJoueurs;
    data['attente_joueurs_demande'] =
        attenteJoueursDemande?.map((e) => e.toJson()).toList();
    data['capitaine_id'] = capitaineId?.toJson();
    data['tournois'] = tournois;
    data['wilaya'] = wilaya;
    data['commune'] = commune;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}

class CapitaineId {
  String? id;
  String? username;
  String? nom;
  int? telephone;

  CapitaineId({this.id, this.username, this.nom, this.telephone});

  CapitaineId.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    username = json['username'] as String?;
    nom = json['nom'] as String?;
    telephone = json['telephone'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['username'] = username;
    data['nom'] = nom;
    data['telephone'] = telephone;
    return data;
  }
}

class AttenteJoueursDemande {
  Joueur? joueur;
  String? post;
  String? id;

  AttenteJoueursDemande({
    this.joueur,
    this.post,
    this.id,
  });

  AttenteJoueursDemande.fromJson(Map<String, dynamic> json) {
    joueur = json['joueur'] != null
        ? Joueur.fromJson(json['joueur'] as Map<String, dynamic>)
        : null;
    post = json['post'] as String?;
    id = json['_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['joueur'] = joueur?.toJson();
    data['post'] = post;
    data['_id'] = id;
    return data;
  }
}

class Joueur {
  String? id;
  String? username;
  String? nom;
  int? telephone;

  Joueur({
    this.id,
    this.username,
    this.nom,
    this.telephone,
  });

  Joueur.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    username = json['username'] as String?;
    nom = json['nom'] as String?;
    telephone = json['telephone'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['username'] = username;
    data['nom'] = nom;
    data['telephone'] = telephone;
    return data;
  }
}
