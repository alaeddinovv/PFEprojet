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
    _data['joueur_id'] = joueurId;
    _data['terrain_id'] = terrainId;
    _data['__v'] = V;
    return _data;
  }
}
