class AdminModel {
  bool? status;
  String? success;
  String? token;
  DataAdminModel? data;

  AdminModel({
    this.status,
    this.success,
    this.token,
    this.data,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      status: json['status'],
      success: json['success'],
      token: json['token'],
      data: json['data'] != null ? DataAdminModel.fromJson(json['data']) : null,
    );
  }
}

class DataAdminModel {
  String? id;
  String? nom;
  String? prenom;
  String? email;
  String? photo;
  int? telephone;
  String? wilaya;
  List<dynamic>? annonces;
  List<dynamic>? tournois;
  List<dynamic>? terrains;
  String? createdAt;
  String? updatedAt;
  int? v;

  DataAdminModel({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.photo,
    this.telephone,
    this.wilaya,
    this.annonces,
    this.tournois,
    this.terrains,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DataAdminModel.fromJson(Map<String, dynamic> json) {
    return DataAdminModel(
      id: json['_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      photo: json['photo'],
      telephone: json['telephone'],
      wilaya: json['wilaya'],
      annonces: json['annonces'],
      tournois: json['tournois'],
      terrains: json['terrains'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "photo": photo,
      "telephone": telephone,
      "wilaya": wilaya,
      "annonces": annonces,
      "tournois": tournois,
      "terrains": terrains,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}
