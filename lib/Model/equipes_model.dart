class EquipesModel {
  EquipesModel({
    required this.data,
    required this.moreDataAvailable,
    required this.nextCursor,
  });
  late final List<EquipesData> data;
  late final bool moreDataAvailable;
  late final String nextCursor;

  EquipesModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => EquipesData.fromJson(e)).toList();
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

class EquipesData {
  EquipesData({
    required this.id,
    required this.nom,
    required this.numeroJoueurs,
    required this.joueurs,
    required this.attenteJoueurs,
    required this.capitaineId,
    required this.tournois,
    required this.wilaya,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String nom;
  late final int numeroJoueurs;
  late final List<dynamic> joueurs;
  late final List<dynamic> attenteJoueurs;
  late final CapitaineId capitaineId;
  late final List<dynamic> tournois;
  late final String wilaya;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  EquipesData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    numeroJoueurs = json['numero_joueurs'];
    joueurs = List.castFrom<dynamic, dynamic>(json['joueurs']);
    attenteJoueurs = List.castFrom<dynamic, dynamic>(json['attente_joueurs']);
    capitaineId = CapitaineId.fromJson(json['capitaine_id']);
    tournois = List.castFrom<dynamic, dynamic>(json['tournois']);
    wilaya = json['wilaya'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['numero_joueurs'] = numeroJoueurs;
    _data['joueurs'] = joueurs;
    _data['attente_joueurs'] = attenteJoueurs;
    _data['capitaine_id'] = capitaineId.toJson();
    _data['tournois'] = tournois;
    _data['wilaya'] = wilaya;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class CapitaineId {
  CapitaineId({
    required this.id,
    required this.nom,
    required this.telephone,
  });
  late final String id;
  late final String nom;
  late final int telephone;

  CapitaineId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    return _data;
  }
}
