class Joueur {
  final String id;
  final String username;
  final int telephone;

  Joueur({
    required this.id,
    required this.username,
    required this.telephone,
  });

  factory Joueur.fromJson(Map<String, dynamic> json) {
    return Joueur(
      id: json['_id'],
      username: json['username'],
      telephone: json['telephone'],
    );
  }
}

class AnnounceOter {
  final String id;
  final String type;
  final String description;
  final String wilaya;
  final String commune;
  final Joueur joueur;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  AnnounceOter({
    required this.id,
    required this.type,
    required this.description,
    required this.wilaya,
    required this.commune,
    required this.joueur,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory AnnounceOter.fromJson(Map<String, dynamic> json) {
    return AnnounceOter(
      id: json['_id'],
      type: json['type'],
      description: json['description'],
      wilaya: json['wilaya'],
      commune: json['commune'],
      joueur: Joueur.fromJson(json['joueur_id']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }
}
