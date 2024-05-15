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
    required this.V,
  });
  late final String id;
  late final String type;
  late final int numeroJoueurs;
  late final List<PostWant> postWant;
  late final String description;
  late final String wilaya;
  late final String commune;
  late final ReservationId reservationId;
  late final TerrainId terrainId;
  late final String joueurId;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  AnnonceSearchJoueurModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    numeroJoueurs = json['numero_joueurs'];
    postWant =
        List.from(json['post_want']).map((e) => PostWant.fromJson(e)).toList();
    description = json['description'];
    wilaya = json['wilaya'];
    commune = json['commune'];
    reservationId = ReservationId.fromJson(json['reservation_id']);
    terrainId = TerrainId.fromJson(json['terrain_id']);
    joueurId = json['joueur_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['type'] = type;
    _data['numero_joueurs'] = numeroJoueurs;
    _data['post_want'] = postWant.map((e) => e.toJson()).toList();
    _data['description'] = description;
    _data['wilaya'] = wilaya;
    _data['commune'] = commune;
    _data['reservation_id'] = reservationId.toJson();
    _data['terrain_id'] = terrainId.toJson();
    _data['joueur_id'] = joueurId;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class PostWant {
  PostWant({
    required this.post,
    required this.find,
    required this.id,
  });
  late final String post;
  late final bool find;
  late final String id;

  PostWant.fromJson(Map<String, dynamic> json) {
    post = json['post'];
    find = json['find'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['post'] = post;
    _data['find'] = find;
    _data['_id'] = id;
    return _data;
  }
}

class ReservationId {
  ReservationId({
    required this.id,
    required this.jour,
    required this.heureDebutTemps,
    required this.duree,
    required this.equipeId1,
    required this.equipeId2,
  });
  late final String id;
  late final String jour;
  late final String heureDebutTemps;
  late final int duree;
  late final EquipeId1 equipeId1;
  late final EquipeId2 equipeId2;

  ReservationId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    jour = json['jour'];
    heureDebutTemps = json['heure_debut_temps'];
    duree = json['duree'];
    equipeId1 = EquipeId1.fromJson(json['equipe_id1']);
    equipeId2 = EquipeId2.fromJson(json['equipe_id2']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['jour'] = jour;
    _data['heure_debut_temps'] = heureDebutTemps;
    _data['duree'] = duree;
    _data['equipe_id1'] = equipeId1.toJson();
    _data['equipe_id2'] = equipeId2.toJson();
    return _data;
  }
}

class EquipeId1 {
  EquipeId1({
    required this.id,
    required this.nom,
    required this.joueurs,
  });
  late final String id;
  late final String nom;
  late final List<Joueurs> joueurs;

  EquipeId1.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    joueurs =
        List.from(json['joueurs']).map((e) => Joueurs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['joueurs'] = joueurs.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Joueurs {
  Joueurs({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
  });
  late final String id;
  late final String nom;
  late final String prenom;
  late final int telephone;

  Joueurs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['telephone'] = telephone;
    return _data;
  }
}

class EquipeId2 {
  EquipeId2({
    required this.id,
    required this.nom,
    required this.joueurs,
  });
  late final String id;
  late final String nom;
  late final List<Joueurs> joueurs;

  EquipeId2.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    joueurs =
        List.from(json['joueurs']).map((e) => Joueurs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['joueurs'] = joueurs.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TerrainId {
  TerrainId({
    required this.coordonnee,
    required this.id,
    required this.adresse,
    required this.nom,
  });
  late final Coordonnee coordonnee;
  late final String id;
  late final String adresse;
  late final String nom;

  TerrainId.fromJson(Map<String, dynamic> json) {
    coordonnee = Coordonnee.fromJson(json['coordonnee']);
    id = json['_id'];
    adresse = json['adresse'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coordonnee'] = coordonnee.toJson();
    _data['_id'] = id;
    _data['adresse'] = adresse;
    _data['nom'] = nom;
    return _data;
  }
}

class Coordonnee {
  Coordonnee({
    required this.latitude,
    required this.longitude,
  });
  late final double latitude;
  late final double longitude;

  Coordonnee.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}
