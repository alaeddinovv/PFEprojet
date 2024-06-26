class AnnonceAdminModel {
  List<AnnonceAdminData>? data;
  bool? moreDataAvailable;
  String? nextCursor;

  AnnonceAdminModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => AnnonceAdminData.fromJson(e))
        .toList();
    moreDataAvailable = json['moreDataAvailable'];
    nextCursor = json['nextCursor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.map((e) => e.toJson()).toList();
    _data['moreDataAvailable'] = moreDataAvailable;
    _data['nextCursor'] = nextCursor;
    return _data;
  }
}

class AnnonceAdminData {
  String? id;
  String? type;
  String? description;
  String? adminId;
  String? joueurId;
  String? createdAt;
  String? updatedAt;
  int? _V;
  String? wilaya;  // Added wilaya field
  String? commune;

  AnnonceAdminData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    description = json['description'];
    adminId = json['admin_id'];
    joueurId = json['joueur_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    _V = json['__v'];
    wilaya = json['wilaya'];  // Deserialize wilaya
    commune = json['commune'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['type'] = type;
    _data['description'] = description;
    _data['admin_id'] = adminId;
    _data['joueur_id'] = joueurId;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = _V;
    _data['wilaya'] = wilaya;  // Serialize wilaya
    _data['commune'] = commune;
    return _data;
  }
}