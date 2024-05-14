import 'package:pfeprojet/Model/user_model.dart';

class EquipeModel {
  List<EquipeModelData>? data;
  bool? moreDataAvailable;
  String? nextCursor;

  EquipeModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => EquipeModelData.fromJson(e))
        .toList();
    moreDataAvailable = json['moreDataAvailable'];
    nextCursor = json['nextCursor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.map((e) => e.toJson()).toList();
    _data['moreDataAvailable'] = moreDataAvailable;
    _data['nextCursor'] = nextCursor;
    return _data;
  }
}

class EquipeModelData {
  String? id;
  String? nom;
  int? numeroJoueurs;
  List<DataJoueurModel>? joueurs;
  List<dynamic>? attenteJoueurs;
  List<dynamic>? attenteJoueursDemande;
  CapitaineId? capitaineId;
  List<dynamic>? tournois;
  String? wilaya;
  String? commune;
  String? createdAt;
  String? updatedAt;
  int? V;

  EquipeModelData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    numeroJoueurs = json['numero_joueurs'];
    joueurs = List.from(json['joueurs'])
        .map((e) => DataJoueurModel.fromJson(e))
        .toList();
    attenteJoueurs =
        List.castFrom<dynamic, dynamic>(json['attente_joueurs'] ?? []);
    attenteJoueursDemande =
        List.castFrom<dynamic, dynamic>(json['attente_joueurs_demande'] ?? []);
    capitaineId = CapitaineId.fromJson(json['capitaine_id'] ?? []);
    tournois = List.castFrom<dynamic, dynamic>(json['tournois'] ?? []);
    wilaya = json['wilaya'];
    commune = json['commune'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['numero_joueurs'] = numeroJoueurs;
    _data['joueurs'] = joueurs!.map((e) => e.toJson()).toList();
    _data['attente_joueurs'] = attenteJoueurs;
    _data['attente_joueurs_demande'] = attenteJoueursDemande;
    _data['capitaine_id'] = capitaineId!.toJson();
    _data['tournois'] = tournois;
    _data['wilaya'] = wilaya;
    _data['commune'] = commune;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

// class Joueurs {
//   String? id;
//   String? username;
//   String? nom;
//   int? telephone;

//   Joueurs.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     username = json['username'];
//     nom = json['nom'];
//     telephone = json['telephone'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['username'] = username;
//     _data['nom'] = nom;
//     _data['telephone'] = telephone;
//     return _data;
//   }
// }

class CapitaineId {
  String? id;
  String? username;
  String? nom;
  int? telephone;

  CapitaineId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    nom = json['nom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['username'] = username;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    return _data;
  }
}
