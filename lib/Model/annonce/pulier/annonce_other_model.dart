class Joueur {
  final String? id;
  final String? username;
  final int? telephone;

  Joueur({
    this.id,
    this.username,
    this.telephone,
  });

  factory Joueur.fromJson(Map<String, dynamic> json) {
    return Joueur(
      id: json['_id'],
      username: json['username'],
      telephone: json['telephone'],
    );
  }
}

class Admin {
  final String? id;
  final String? nom;
  final int? telephone;

  Admin({
    this.id,
    this.nom,
    this.telephone,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['_id'],
      nom: json['nom'],
      telephone: json['telephone'],
    );
  }
}

class AnnounceOter {
  final String? id;
  final String? type;
  final String? description;
  final String? wilaya;
  final String? commune;
  final dynamic user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  AnnounceOter({
    this.id,
    this.type,
    this.description,
    this.wilaya,
    this.commune,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory AnnounceOter.fromJson(Map<String, dynamic> json) {
    dynamic user;
    if (json['joueur_id'] != null) {
      user = Joueur.fromJson(json['joueur_id']);
    } else if (json['admin_id'] != null) {
      user = Admin.fromJson(json['admin_id']);
    }

    return AnnounceOter(
      id: json['_id'],
      type: json['type'],
      description: json['description'],
      wilaya: json['wilaya'],
      commune: json['commune'],
      user: user,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      version: json['__v'],
    );
  }
}
