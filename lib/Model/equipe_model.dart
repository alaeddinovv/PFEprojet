class EquipeModel {
  EquipeModel({
    required this.data,
    required this.moreDataAvailable,
    required this.nextCursor,
  });
  late final List<EquipeData> data;
  late final bool moreDataAvailable;
  late final String nextCursor;

  EquipeModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => EquipeData.fromJson(e)).toList();
    moreDataAvailable = json['moreDataAvailable'];
    nextCursor = json['nextCursor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['moreDataAvailable'] = moreDataAvailable;
    _data['nextCursor'] = nextCursor;
    return _data;
  }
}

class EquipeData {
  EquipeData({
    required this.id,
    required this.nom,
    required this.numeroJoueurs,
    required this.joueurs,
    required this.attenteJoueurs,
    required this.attenteJoueursDemande,
    required this.capitaineId,
    required this.tournois,
    required this.wilaya,
    required this.commune,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String nom;
  late final int numeroJoueurs;
  late final List<Joueurs> joueurs;
  late final List<AttenteJoueurs> attenteJoueurs;
  late final List<AttenteJoueursDemande> attenteJoueursDemande;
  late final CapitaineId capitaineId;
  late final List<dynamic> tournois;
  late final String wilaya;
  late final String commune;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  EquipeData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    numeroJoueurs = json['numero_joueurs'];
    joueurs =
        List.from(json['joueurs']).map((e) => Joueurs.fromJson(e)).toList();
    attenteJoueurs = List.from(json['attente_joueurs'] ?? [])
        .map((e) => AttenteJoueurs.fromJson(e))
        .toList();
    attenteJoueursDemande = List.from(json['attente_joueurs_demande'] ?? [])
        .map((e) => AttenteJoueursDemande.fromJson(e))
        .toList();
    capitaineId = CapitaineId.fromJson(json['capitaine_id'] ?? []);
    tournois = List.castFrom<dynamic, dynamic>(json['tournois'] ?? []);
    wilaya = json['wilaya'];
    commune = json['commune'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['numero_joueurs'] = numeroJoueurs;
    _data['joueurs'] = joueurs.map((e) => e.toJson()).toList();
    _data['attente_joueurs'] = attenteJoueurs.map((e) => e.toJson()).toList();
    _data['attente_joueurs_demande'] =
        attenteJoueursDemande.map((e) => e.toJson()).toList();
    _data['capitaine_id'] = capitaineId.toJson();
    _data['tournois'] = tournois;
    _data['wilaya'] = wilaya;
    _data['commune'] = commune;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Joueurs {
  Joueurs({
    required this.id,
    required this.username,
    required this.nom,
    required this.telephone,
  });
  late final String id;
  late final String username;
  late final String nom;
  late final int telephone;

  Joueurs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    nom = json['nom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['username'] = username;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    return _data;
  }
}

class AttenteJoueurs {
  AttenteJoueurs({
    required this.id,
    required this.username,
    required this.nom,
    required this.telephone,
  });
  late final String id;
  late final String username;
  late final String nom;
  late final int telephone;

  AttenteJoueurs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    nom = json['nom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['username'] = username;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    return _data;
  }
}

class CapitaineId {
  CapitaineId({
    required this.id,
    required this.username,
    required this.nom,
    required this.telephone,
  });
  late final String id;
  late final String username;
  late final String nom;
  late final int telephone;

  CapitaineId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    nom = json['nom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['username'] = username;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    return _data;
  }
}

class AttenteJoueursDemande {
  AttenteJoueursDemande({
    required this.id,
    required this.username,
    required this.nom,
    required this.telephone,
  });
  late final String id;
  late final String username;
  late final String nom;
  late final int telephone;

  AttenteJoueursDemande.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    nom = json['nom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['username'] = username;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    return _data;
  }
}
