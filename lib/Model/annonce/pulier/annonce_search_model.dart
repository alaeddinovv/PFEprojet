class AnnonceSearchJoueurModel {
  String id;
  String type;
  int numeroJoueurs;
  List<PostWant> postWant;
  String description;
  String wilaya;
  String commune;
  ReservationId reservationId;
  TerrainId terrainId;
  JoueurId joueurId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

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

  factory AnnonceSearchJoueurModel.fromJson(Map<String, dynamic> json) {
    return AnnonceSearchJoueurModel(
      id: json['_id'] as String,
      type: json['type'] as String,
      numeroJoueurs: json['numero_joueurs'] as int,
      postWant: (json['post_want'] as List<dynamic>)
          .map((e) => PostWant.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      wilaya: json['wilaya'] as String,
      commune: json['commune'] as String,
      reservationId: ReservationId.fromJson(
          json['reservation_id'] as Map<String, dynamic>),
      terrainId: TerrainId.fromJson(json['terrain_id'] as Map<String, dynamic>),
      joueurId: JoueurId.fromJson(json['joueur_id'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}

class PostWant {
  String post;
  bool find;

  PostWant({
    required this.post,
    required this.find,
  });

  factory PostWant.fromJson(Map<String, dynamic> json) {
    return PostWant(
      post: json['post'] as String,
      find: json['find'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'post': post,
      'find': find,
    };
  }
}

class ReservationId {
  String id;
  DateTime jour;
  String heureDebutTemps;
  int duree;
  Equipe? equipeId1;
  Equipe? equipeId2;

  ReservationId({
    required this.id,
    required this.jour,
    required this.heureDebutTemps,
    required this.duree,
    this.equipeId1,
    this.equipeId2,
  });

  factory ReservationId.fromJson(Map<String, dynamic> json) {
    return ReservationId(
      id: json['_id'] as String,
      jour: DateTime.parse(json['jour'] as String),
      heureDebutTemps: json['heure_debut_temps'] as String,
      duree: json['duree'] as int,
      equipeId1: json['equipe_id1'] != null
          ? Equipe.fromJson(json['equipe_id1'] as Map<String, dynamic>)
          : null,
      equipeId2: json['equipe_id2'] != null
          ? Equipe.fromJson(json['equipe_id2'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Equipe {
  String id;
  String nom;
  List<Joueur> joueurs;
  String? capitaine_id;

  Equipe({
    required this.id,
    required this.nom,
    required this.joueurs,
    this.capitaine_id,
  });

  factory Equipe.fromJson(Map<String, dynamic> json) {
    return Equipe(
      id: json['_id'] as String,
      nom: json['nom'] as String,
      joueurs: (json['joueurs'] as List<dynamic>)
          .map((e) => Joueur.fromJson(e as Map<String, dynamic>))
          .toList(),
      capitaine_id: json['capitaine_id'] as String?,
    );
  }
}

class Joueur {
  String id;
  String nom;
  String prenom;
  int telephone;

  Joueur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
  });

  factory Joueur.fromJson(Map<String, dynamic> json) {
    return Joueur(
      id: json['_id'] as String,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      telephone: json['telephone'] as int,
    );
  }
}

class TerrainId {
  Coordonnee coordonnee;
  String id;
  String nom;
  String adresse;

  TerrainId({
    required this.coordonnee,
    required this.id,
    required this.nom,
    required this.adresse,
  });

  factory TerrainId.fromJson(Map<String, dynamic> json) {
    return TerrainId(
      coordonnee:
          Coordonnee.fromJson(json['coordonnee'] as Map<String, dynamic>),
      id: json['_id'] as String,
      nom: json['nom'] as String,
      adresse: json['adresse'] as String,
    );
  }
}

class Coordonnee {
  double latitude;
  double longitude;

  Coordonnee({
    required this.latitude,
    required this.longitude,
  });

  factory Coordonnee.fromJson(Map<String, dynamic> json) {
    return Coordonnee(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}

class JoueurId {
  String id;
  String username;
  int telephone;

  JoueurId({
    required this.id,
    required this.username,
    required this.telephone,
  });

  factory JoueurId.fromJson(Map<String, dynamic> json) {
    return JoueurId(
      id: json['_id'] as String,
      username: json['username'] as String,
      telephone: json['telephone'] as int,
    );
  }
}
