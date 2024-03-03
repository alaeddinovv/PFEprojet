class AdminModel {
  bool? status;
  String? success;
  String? token;
  UserDataDetails? data;

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
      data:
          json['data'] != null ? UserDataDetails.fromJson(json['data']) : null,
    );
  }
}

class UserDataDetails {
  String? id;
  String? nom;
  String? prenom;
  String? email;
  int? telephone;
  String? wilaya;
  List<dynamic>? annonces;
  List<dynamic>? tournois;
  List<dynamic>? terrains;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserDataDetails({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.telephone,
    this.wilaya,
    this.annonces,
    this.tournois,
    this.terrains,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserDataDetails.fromJson(Map<String, dynamic> json) {
    return UserDataDetails(
      id: json['_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
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
}
