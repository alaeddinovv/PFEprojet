class TerrainPaginationModel {
  TerrainPaginationModel({
    required this.data,
    required this.moreDataAvailable,
    required this.nextCursor,
  });
  late final List<TarrainPaginationData> data;
  late final bool moreDataAvailable;
  late final String nextCursor;

  TerrainPaginationModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => TarrainPaginationData.fromJson(e))
        .toList();
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

class TarrainPaginationData {
  TarrainPaginationData({
    required this.coordonnee,
    required this.id,
    required this.nom,
    required this.largeur,
    required this.longeur,
    // required this.superficie,
    required this.adresse,
    required this.heureDebutTemps,
    required this.heureFinTemps,
    required this.dureeCreneau,
    required this.prix,
    required this.description,
    required this.capacite,
    required this.etat,
    required this.reservations,
    required this.nonReservableTimeBlocks,
    required this.adminId,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final Coordonnee coordonnee;
  late final String id;
  late final String nom;
  late final int largeur;
  late final int longeur;
  // late final int superficie;
  late final String adresse;
  late final String heureDebutTemps;
  late final String heureFinTemps;
  late final String dureeCreneau;
  late final int prix;
  late final String description;
  late final int capacite;
  late final String etat;
  late final List<dynamic> reservations;
  late final List<NonReservableTimeBlocks> nonReservableTimeBlocks;
  late final AdminId adminId;
  late final List<String> photos;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  TarrainPaginationData.fromJson(Map<String, dynamic> json) {
    coordonnee = Coordonnee.fromJson(json['coordonnee']);
    id = json['_id'];
    nom = json['nom'];
    largeur = json['largeur'];
    longeur = json['longeur'];
    // superficie = json['superficie'];
    adresse = json['adresse'];
    heureDebutTemps = json['heure_debut_temps'];
    heureFinTemps = json['heure_fin_temps'];
    dureeCreneau = json['duree_creneau'];
    prix = json['prix'];
    description = json['description'];
    capacite = json['capacite'];
    etat = json['etat'];
    reservations = List.castFrom<dynamic, dynamic>(json['reservations']);
    nonReservableTimeBlocks = List.from(json['nonReservableTimeBlocks'])
        .map((e) => NonReservableTimeBlocks.fromJson(e))
        .toList();
    adminId = AdminId.fromJson(json['admin_id']);
    photos = List.castFrom<dynamic, String>(json['photos']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coordonnee'] = coordonnee.toJson();
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['largeur'] = largeur;
    _data['longeur'] = longeur;
    // _data['superficie'] = superficie;
    _data['adresse'] = adresse;
    _data['heure_debut_temps'] = heureDebutTemps;
    _data['heure_fin_temps'] = heureFinTemps;
    _data['duree_creneau'] = dureeCreneau;
    _data['prix'] = prix;
    _data['description'] = description;
    _data['capacite'] = capacite;
    _data['etat'] = etat;
    _data['reservations'] = reservations;
    _data['nonReservableTimeBlocks'] =
        nonReservableTimeBlocks.map((e) => e.toJson()).toList();
    _data['admin_id'] = adminId.toJson();
    _data['photos'] = photos;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
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

class NonReservableTimeBlocks {
  NonReservableTimeBlocks({
    required this.day,
    required this.hours,
    required this.id,
  });
  late final String day;
  late final List<String> hours;
  late final String id;

  NonReservableTimeBlocks.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hours = List.castFrom<dynamic, String>(json['hours']);
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['hours'] = hours;
    _data['_id'] = id;
    return _data;
  }
}

class AdminId {
  AdminId({
    required this.id,
    required this.nom,
    required this.telephone,
    required this.wilaya,
  });
  late final String id;
  late final String nom;
  late final int telephone;
  late final String wilaya;

  AdminId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    telephone = json['telephone'];
    wilaya = json['wilaya'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['telephone'] = telephone;
    _data['wilaya'] = wilaya;
    return _data;
  }
}
