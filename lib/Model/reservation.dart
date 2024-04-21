class ReservationModel {
  ReservationModel({
    required this.id,
    required this.jour,
    required this.heureDebutTemps,
    required this.duree,
    required this.etat,
    required this.payment,
    required this.joueurId,
    required this.terrainId,
    required this.V,
  });
  late final String id;
  late final DateTime jour;
  late final String heureDebutTemps;
  late final int duree;
  late final String etat;
  late final bool payment;
  late final String joueurId;
  late final String terrainId;
  late final int V;

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    jour = DateTime.parse(json['jour']);
    heureDebutTemps = json['heure_debut_temps'];
    duree = json['duree'];
    etat = json['etat'];
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
    _data['payment'] = payment;
    _data['joueur_id'] = joueurId;
    _data['terrain_id'] = terrainId;
    _data['__v'] = V;
    return _data;
  }
}
