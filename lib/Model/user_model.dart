class UserModel {
  UserModel({
    required this.status,
    required this.success,
    required this.token,
    required this.data,
  });
  late final bool status;
  late final String success;
  late final String token;
  late final Data data;

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
    _data['data'] = data.toJson();
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
    required this.motDePasse,
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
  });
  late final String id;
  late final String nom;
  late final String prenom;
  late final String email;
  late final int telephone;
  late final String motDePasse;
  late final int age;
  late final String poste;
  late final String wilaya;
  late final String photo;
  late final List<dynamic> equipes;
  late final List<dynamic> annonces;
  late final List<dynamic> creneausReserve;
  late final List<dynamic> creneausFinale;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    telephone = json['telephone'];
    motDePasse = json['mot_de_passe'];
    age = json['age'];
    poste = json['poste'];
    wilaya = json['wilaya'];
    photo = json['photo'];
    equipes = List.castFrom<dynamic, dynamic>(json['equipes']);
    annonces = List.castFrom<dynamic, dynamic>(json['annonces']);
    creneausReserve = List.castFrom<dynamic, dynamic>(json['creneaus_reserve']);
    creneausFinale = List.castFrom<dynamic, dynamic>(json['creneaus_finale']);
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
    _data['mot_de_passe'] = motDePasse;
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
