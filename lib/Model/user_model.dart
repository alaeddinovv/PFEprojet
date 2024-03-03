class UserModel {
  bool? status;
  String? success;
  String? token;
  Data? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    token = json['token'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['success'] = success;
    _data['token'] = token;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.age,
    required this.poste,
    required this.wilaya,
    required this.photo,
    required this.equipes,
    required this.annonces,
    required this.creneausReserve,
    required this.creneausFinale,
    required this.createdAt,
    required this.updatedAt,
    // required this._V,
  });
  String? id;
  String? nom;
  String? prenom;
  String? email;
  int? telephone;
  int? age;
  String? poste;
  String? wilaya;
  String? photo;
  List<dynamic>? equipes;
  List<dynamic>? annonces;
  List<dynamic>? creneausReserve;
  List<dynamic>? creneausFinale;
  String? createdAt;
  String? updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    telephone = json['telephone'];
    age = json['age'];
    poste = json['poste'];
    wilaya = json['wilaya'];
    photo = json['photo'];
    equipes = json['equipes'];
    annonces = json['annonces'];
    creneausReserve = json['creneaus_reserve'];
    creneausFinale = json['creneaus_finale'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['email'] = email;
    _data['telephone'] = telephone;
    _data['age'] = age;
    _data['poste'] = poste;
    _data['wilaya'] = wilaya;
    _data['photo'] = photo;
    _data['equipes'] = equipes;
    _data['annonces'] = annonces;
    _data['creneaus_reserve'] = creneausReserve;
    _data['creneaus_finale'] = creneausFinale;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}
