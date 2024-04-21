class ReservationModel {
  final String id;
  final DateTime jour;
  final String heureDebutTemps;
  final int duree; // Duration in weeks
  final String etat;
  final bool payment;
  final String joueurId;
  final String terrainId;

  ReservationModel({
    required this.id,
    required this.jour,
    required this.heureDebutTemps,
    required this.duree,
    required this.etat,
    required this.payment,
    required this.joueurId,
    required this.terrainId,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['_id'],
      jour: DateTime.parse(json['jour']),
      heureDebutTemps: json['heure_debut_temps'],
      duree: json['duree'],
      etat: json['etat'],
      payment: json['payment'],
      joueurId: json['joueur_id'],
      terrainId: json['terrain_id'],
    );
  }
}
