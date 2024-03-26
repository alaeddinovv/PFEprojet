class AnnonceModel {
  String? type;
  String? description;
  String? adminId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  AnnonceModel({
    this.type,
    this.description,
    this.adminId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AnnonceModel.fromJson(Map<String, dynamic> json) {
    return AnnonceModel(
      type: json['type'],
      description: json['description'],
      adminId: json['admin_id'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
