import 'package:pfeprojet/Model/admin_medel.dart';

class TerrainModel {
  String? nom;
  int? largeur;
  int? longeur;
  int? superficie;
  String? adresse;
  String? heureDebutTemps;
  String? heureFinTemps;
  String? dureeCreneau;
  int? prix;
  String? description;
  int? capacite;
  String? etat;
  Coordonnee? coordonnee;
  List<dynamic>? reservations;
  List<NonReservableTimeBlocks>? nonReservableTimeBlocks;
  dynamic
      admin; //! in get my terrian (api backend) not get json for detail admin just string adminId
  List<dynamic>? photos;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? V;

  TerrainModel.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    largeur = json['largeur'];
    longeur = json['longeur'];
    superficie = json['superficie'];
    adresse = json['adresse'];
    heureDebutTemps = json['heure_debut_temps'];
    heureFinTemps = json['heure_fin_temps'];
    dureeCreneau = json['duree_creneau'];
    prix = json['prix'];
    description = json['description'];
    capacite = json['capacite'];
    etat = json['etat'];
    coordonnee = Coordonnee.fromJson(json['coordonnee']);
    reservations = List.castFrom<dynamic, dynamic>(json['reservations']);
    nonReservableTimeBlocks = List.from(json['nonReservableTimeBlocks'])
        .map((e) => NonReservableTimeBlocks.fromJson(e))
        .toList();
    if (json['admin_id'] is String) {
      admin = json[
          'admin_id']; //! in get my terrian (api backend) not get json for detail admin just string adminId
    } else {
      admin = DataAdminModel.fromJson(json['admin_id']);
    }

    photos = List.castFrom<dynamic, dynamic>(json['photos']);
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nom'] = nom;
    _data['largeur'] = largeur;
    _data['longeur'] = longeur;
    _data['superficie'] = superficie;
    _data['adresse'] = adresse;
    _data['heure_debut_temps'] = heureDebutTemps;
    _data['heure_fin_temps'] = heureFinTemps;
    _data['duree_creneau'] = dureeCreneau;
    _data['prix'] = prix;
    _data['description'] = description;
    _data['capacite'] = capacite;
    _data['etat'] = etat;
    _data['coordonnee'] = coordonnee!.toJson();
    _data['reservations'] = reservations;
    _data['nonReservableTimeBlocks'] =
        nonReservableTimeBlocks!.map((e) => e.toJson()).toList();
    _data['admin_id'] = admin!.toJson();
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
  });
  String? day;
  List<String>? hours;

  NonReservableTimeBlocks.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hours = List.castFrom<dynamic, String>(json['hours']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['hours'] = hours;
    return _data;
  }
}
