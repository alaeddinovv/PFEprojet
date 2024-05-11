import 'package:pfeprojet/Model/equipe_model.dart';

class ReservationModel {
  String? id;
  DateTime? jour;
  String? heureDebutTemps;
  int? duree;
  String? etat;
  String? reservationGroupId;
  bool? payment;
  String? joueurId;
  String? terrainId;
  EquipeData? equipe;
  String?
      equipeId; //! equipe w equipeId n9der ndirhom 7aja wahda bs7 fragthom bh nmadlhom type wymdli i9tirahat(ya tkon kayna equipe wla equipeId)
  // EquipeData? equipe2;
  // String? equipeId2;
  int? V;

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    jour = DateTime.parse(json['jour']);
    heureDebutTemps = json['heure_debut_temps'];
    duree = json['duree'];
    etat = json['etat'];
    reservationGroupId = json['reservation_group_id'];
    payment = json['payment'];
    joueurId = json['joueur_id'];
    terrainId = json['terrain_id'];
    if (json['equipe_id'] != null) {
      if (json['equipe_id'] is String) {
        equipeId = json['equipe_id'];
      } else {
        equipe = EquipeData.fromJson(json['equipe_id']);
      }
    }
    // if (json['equipe_id2'] != null) {
    //   if (json['equipe_id2'] is String) {
    //     equipeId2 = json['equipe_id2'];
    //   } else {
    //     equipe2 = EquipeData.fromJson(json['equipe_id2']);
    //   }
    // }
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['jour'] = jour;
    _data['heure_debut_temps'] = heureDebutTemps;
    _data['duree'] = duree;
    _data['etat'] = etat;
    _data['reservation_group_id'] = reservationGroupId;
    _data['payment'] = payment;
    _data['terrain_id'] = terrainId;
    _data['joueur_id'] = joueurId;
    if (equipe != null) {
      if (equipe is String) {
        _data['equipe_id1'] = equipeId;
      } else {
        _data['equipe_id1'] = equipe!.toJson();
      }
    }
    // if (equipe2 != null) {
    //   if (equipe2 is String) {
    //     _data['equipe_id2'] = equipeId2;
    //   } else {
    //     _data['equipe_id2'] = equipe2!.toJson();
    //   }
    // }

    _data['__v'] = V;
    return _data;
  }
}

// class EquipeeModel {
//   String? id;
//   String? nom;
//   int? numeroJoueurs;
//   List<Joueurs>? joueurs;
//   List<dynamic>? attenteJoueurs;
//   List<dynamic>? attenteJoueursDemande;
//   CapitaineId? capitaineId;
//   List<dynamic>? tournois;
//   String? wilaya;
//   String? commune;
//   String? createdAt;
//   String? updatedAt;
//   int? V;

//   EquipeeModel.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     nom = json['nom'];
//     numeroJoueurs = json['numero_joueurs'];
//     joueurs =
//         List.from(json['joueurs']).map((e) => Joueurs.fromJson(e)).toList();
//     attenteJoueurs =
//         List.castFrom<dynamic, dynamic>(json['attente_joueurs'] ?? []);
//     attenteJoueursDemande =
//         List.castFrom<dynamic, dynamic>(json['attente_joueurs_demande'] ?? []);
//     capitaineId = CapitaineId.fromJson(json['capitaine_id'] ?? []);
//     tournois = List.castFrom<dynamic, dynamic>(json['tournois'] ?? []);
//     wilaya = json['wilaya'];
//     commune = json['commune'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['nom'] = nom;
//     _data['numero_joueurs'] = numeroJoueurs;
//     _data['joueurs'] = joueurs!.map((e) => e.toJson()).toList();
//     _data['attente_joueurs'] = attenteJoueurs;
//     _data['attente_joueurs_demande'] = attenteJoueursDemande;
//     _data['capitaine_id'] = capitaineId!.toJson();
//     _data['tournois'] = tournois;
//     _data['wilaya'] = wilaya;
//     _data['commune'] = commune;
//     _data['createdAt'] = createdAt;
//     _data['updatedAt'] = updatedAt;
//     _data['__v'] = V;
//     return _data;
//   }
// }

// class Joueurs {
//   String? id;
//   String? username;
//   String? nom;
//   String? poste;
//   int? telephone;

//   Joueurs.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     username = json['username'];
//     nom = json['nom'];
//     poste = json['poste'];
//     telephone = json['telephone'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['username'] = username;
//     _data['nom'] = nom;
//     _data['poste'] = poste;
//     _data['telephone'] = telephone;
//     return _data;
//   }
// }

// class CapitaineId {
//   String? id;
//   String? username;
//   String? nom;
//   int? telephone;

//   CapitaineId.fromJson(Map<String, dynamic> json) {
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
