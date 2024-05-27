import 'package:pfeprojet/Model/houssem/equipe_model.dart';

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
  EquipeModelData? equipe1;
  String? equipeId1;
  EquipeModelData? equipe2;
  String? equipeId2;
  int? v;

  ReservationModel({
    this.id,
    this.jour,
    this.heureDebutTemps,
    this.duree,
    this.etat,
    this.reservationGroupId,
    this.payment,
    this.joueurId,
    this.terrainId,
    this.equipe1,
    this.equipeId1,
    this.equipe2,
    this.equipeId2,
    this.v,
  });

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    jour = json['jour'] != null ? DateTime.parse(json['jour']) : null;
    heureDebutTemps = json['heure_debut_temps'] as String?;
    duree = json['duree'] as int?;
    etat = json['etat'] as String?;
    reservationGroupId = json['reservation_group_id'] as String?;
    payment = json['payment'] as bool?;
    joueurId = json['joueur_id'] as String?;
    terrainId = json['terrain_id'] as String?;
    if (json['equipe_id1'] != null) {
      if (json['equipe_id1'] is String) {
        equipeId1 = json['equipe_id1'] as String?;
      } else {
        equipe1 = EquipeModelData.fromJson(
            json['equipe_id1'] as Map<String, dynamic>);
      }
    }
    if (json['equipe_id2'] != null) {
      if (json['equipe_id2'] is String) {
        equipeId2 = json['equipe_id2'] as String?;
      } else {
        equipe2 = EquipeModelData.fromJson(
            json['equipe_id2'] as Map<String, dynamic>);
      }
    }
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['jour'] = jour?.toIso8601String();
    data['heure_debut_temps'] = heureDebutTemps;
    data['duree'] = duree;
    data['etat'] = etat;
    data['reservation_group_id'] = reservationGroupId;
    data['payment'] = payment;
    data['terrain_id'] = terrainId;
    data['joueur_id'] = joueurId;
    if (equipe1 != null) {
      if (equipe1 is String) {
        data['equipe_id1'] = equipeId1;
      } else {
        data['equipe_id1'] = equipe1!.toJson();
      }
    }
    if (equipe2 != null) {
      if (equipe2 is String) {
        data['equipe_id2'] = equipeId2;
      } else {
        data['equipe_id2'] = equipe2!.toJson();
      }
    }
    data['__v'] = v;
    return data;
  }
}
