
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/Model/user_model.dart';
class AnnonceModel {
  List<AnnonceData>? data;
  bool? moreDataAvailable;
  String? nextCursor;

  AnnonceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List.from(json['data']).map((e) => AnnonceData.fromJson(e)).toList();
    }
    moreDataAvailable = json['moreDataAvailable'];
    nextCursor = json['nextCursor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data?.map((e) => e.toJson()).toList();
    _data['moreDataAvailable'] = moreDataAvailable;
    _data['nextCursor'] = nextCursor;
    return _data;
  }
}

class AnnonceData {
  String? id;
  String? type;
  String? description;
  DataAdminModel? admin;
  DataJoueurModel? joueur;
  String? createdAt;
  String? updatedAt;
  int? _V;
  String? wilaya;
  String? commune;

  AnnonceData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    description = json['description'];
    admin = json['admin_id'] is Map ? DataAdminModel.fromJson(json['admin_id']) : null;
    joueur = json['joueur_id'] is Map ? DataJoueurModel.fromJson(json['joueur_id']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    _V = json['__v'];
    wilaya = json['wilaya'];
    commune = json['commune'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['type'] = type;
    _data['description'] = description;
    _data['admin_id'] = admin?.toJson();
    _data['joueur_id'] = joueur?.toJson();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = _V;
    _data['wilaya'] = wilaya;
    _data['commune'] = commune;
    return _data;
  }
}
