class AnnonceSearchJoueurModel {
  AnnonceSearchJoueurModel({
    required this.id,
    required this.type,
    required this.numeroJoueurs,
    required this.postWant,
    required this.description,
    required this.wilaya,
    required this.commune,
    required this.reservationId,
    required this.terrainId,
    required this.joueurId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String type;
  final int numeroJoueurs;
  final List<PostWant> postWant;
  final String description;
  final String wilaya;
  final String commune;
  final ReservationId? reservationId;
  final TerrainId terrainId;
  final String joueurId;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory AnnonceSearchJoueurModel.fromJson(Map<String, dynamic> json) {
    return AnnonceSearchJoueurModel(
      id: json['_id'],
      type: json['type'],
      numeroJoueurs: json['numero_joueurs'],
      postWant: List<PostWant>.from(
          json['post_want'].map((e) => PostWant.fromJson(e))),
      description: json['description'],
      wilaya: json['wilaya'],
      commune: json['commune'],
      reservationId: json['reservation_id'] != null
          ? ReservationId.fromJson(json['reservation_id'])
          : null,
      terrainId: TerrainId.fromJson(json['terrain_id']),
      joueurId: json['joueur_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'numero_joueurs': numeroJoueurs,
      'post_want': postWant.map((e) => e.toJson()).toList(),
      'description': description,
      'wilaya': wilaya,
      'commune': commune,
      'reservation_id': reservationId?.toJson(),
      'terrain_id': terrainId.toJson(),
      'joueur_id': joueurId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class PostWant {
  PostWant({
    required this.post,
    required this.find,
    required this.id,
  });

  final String post;
  final bool find;
  final String id;

  factory PostWant.fromJson(Map<String, dynamic> json) {
    return PostWant(
      post: json['post'],
      find: json['find'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post': post,
      'find': find,
      '_id': id,
    };
  }
}

class ReservationId {
  ReservationId({
    required this.id,
    required this.jour,
    required this.heureDebutTemps,
    required this.duree,
    this.equipeId1,
    this.equipeId2,
  });

  final String id;
  final String jour;
  final String heureDebutTemps;
  final int duree;
  final EquipeId1? equipeId1;
  final EquipeId2? equipeId2;

  factory ReservationId.fromJson(Map<String, dynamic> json) {
    return ReservationId(
      id: json['_id'],
      jour: json['jour'],
      heureDebutTemps: json['heure_debut_temps'],
      duree: json['duree'],
      equipeId1: json['equipe_id1'] != null
          ? EquipeId1.fromJson(json['equipe_id1'])
          : null,
      equipeId2: json['equipe_id2'] != null
          ? EquipeId2.fromJson(json['equipe_id2'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'jour': jour,
      'heure_debut_temps': heureDebutTemps,
      'duree': duree,
      'equipe_id1': equipeId1?.toJson(),
      'equipe_id2': equipeId2?.toJson(),
    };
  }
}

class EquipeId1 {
  EquipeId1({
    required this.id,
    required this.nom,
    required this.joueurs,
  });

  final String id;
  final String nom;
  final List<Joueurs> joueurs;

  factory EquipeId1.fromJson(Map<String, dynamic> json) {
    return EquipeId1(
      id: json['_id'],
      nom: json['nom'],
      joueurs:
          List<Joueurs>.from(json['joueurs'].map((e) => Joueurs.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': nom,
      'joueurs': joueurs.map((e) => e.toJson()).toList(),
    };
  }
}

class Joueurs {
  Joueurs({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
  });

  final String id;
  final String nom;
  final String prenom;
  final int telephone;

  factory Joueurs.fromJson(Map<String, dynamic> json) {
    return Joueurs(
      id: json['_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
    };
  }
}

class EquipeId2 {
  EquipeId2({
    required this.id,
    required this.nom,
    required this.joueurs,
  });

  final String id;
  final String nom;
  final List<Joueurs> joueurs;

  factory EquipeId2.fromJson(Map<String, dynamic> json) {
    return EquipeId2(
      id: json['_id'],
      nom: json['nom'],
      joueurs:
          List<Joueurs>.from(json['joueurs'].map((e) => Joueurs.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': nom,
      'joueurs': joueurs.map((e) => e.toJson()).toList(),
    };
  }
}

class TerrainId {
  TerrainId({
    required this.coordonnee,
    required this.id,
    required this.adresse,
    required this.nom,
  });

  final Coordonnee coordonnee;
  final String id;
  final String adresse;
  final String nom;

  factory TerrainId.fromJson(Map<String, dynamic> json) {
    return TerrainId(
      coordonnee: Coordonnee.fromJson(json['coordonnee']),
      id: json['_id'],
      adresse: json['adresse'],
      nom: json['nom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordonnee': coordonnee.toJson(),
      '_id': id,
      'adresse': adresse,
      'nom': nom,
    };
  }
}

class Coordonnee {
  Coordonnee({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory Coordonnee.fromJson(Map<String, dynamic> json) {
    return Coordonnee(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
