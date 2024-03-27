class TerrainModel {
  TerrainModel({
    required this.coordonnee,
    required this.id,
    required this.largeur,
    required this.longeur,
    required this.superficie,
    required this.adresse,
    required this.sTemps,
    required this.eTemps,
    required this.prix,
    required this.description,
    required this.capacite,
    required this.etat,
    required this.reservations,
    required this.adminId,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  Coordonnee? coordonnee;
  String? id;
  int? largeur;
  int? longeur;
  int? superficie;
  String? adresse;
  String? sTemps;
  String? eTemps;
  int? prix;
  String? description;
  int? capacite;
  String? etat;
  List<dynamic>? reservations;
  String? adminId;
  List<dynamic>? photos;
  String? createdAt;
  String? updatedAt;
  int? V;

  TerrainModel.fromJson(Map<String, dynamic> json) {
    coordonnee = Coordonnee.fromJson(json['coordonnee']);
    id = json['_id'];
    largeur = json['largeur'];
    longeur = json['longeur'];
    superficie = json['superficie'];
    adresse = json['adresse'];
    sTemps = json['s_temps'];
    eTemps = json['e_temps'];
    prix = json['prix'];
    description = json['description'];
    capacite = json['capacite'];
    etat = json['etat'];
    reservations = List.castFrom<dynamic, dynamic>(json['reservations']);
    adminId = json['admin_id'];
    photos = List.castFrom<dynamic, dynamic>(json['photos']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coordonnee'] = coordonnee?.toJson();
    _data['_id'] = id;
    _data['largeur'] = largeur;
    _data['longeur'] = longeur;
    _data['superficie'] = superficie;
    _data['adresse'] = adresse;
    _data['s_temps'] = sTemps;
    _data['e_temps'] = eTemps;
    _data['prix'] = prix;
    _data['description'] = description;
    _data['capacite'] = capacite;
    _data['etat'] = etat;
    _data['reservations'] = reservations;
    _data['admin_id'] = adminId;
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
  int? latitude;
  int? longitude;

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
