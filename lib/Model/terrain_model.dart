class TerrainModel {
  TerrainModel({
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
    required this.coordonnee,
    required this.reservations,
    required this.nonReservableTimeBlocks,
    required this.adminId,
    required this.photos,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
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
  Coordonnee? coordonnee;
  List<dynamic>? reservations;
  List<NonReservableTimeBlocks>? nonReservableTimeBlocks;
  String? adminId;
  List<dynamic>? photos;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? V;

  TerrainModel.fromJson(Map<String, dynamic> json) {
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
    coordonnee = Coordonnee.fromJson(json['coordonnee']);
    reservations = List.castFrom<dynamic, dynamic>(json['reservations']);
    nonReservableTimeBlocks = List.from(json['nonReservableTimeBlocks'])
        .map((e) => NonReservableTimeBlocks.fromJson(e))
        .toList();
    adminId = json['admin_id'];
    photos = List.castFrom<dynamic, dynamic>(json['photos']);
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['coordonnee'] = coordonnee!.toJson();
    _data['reservations'] = reservations;
    _data['nonReservableTimeBlocks'] =
        nonReservableTimeBlocks!.map((e) => e.toJson()).toList();
    _data['admin_id'] = adminId;
    _data['photos'] = photos;
    _data['_id'] = id;
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
  double? latitude;
  double? longitude;

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
  String? day;
  List<String>? hours;
  String? id;

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
