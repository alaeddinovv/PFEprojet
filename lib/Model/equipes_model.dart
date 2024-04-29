import 'package:pfeprojet/Model/user_model.dart';
class EquipesModel {
  List<EquipesData>? data;
  bool? moreDataAvailable;
  String? nextCursor;

  EquipesModel.fromJson(Map<String, dynamic> json){
    if (json['data'] != null) {
      data = List.from(json['data']).map((e)=>EquipesData.fromJson(e)).toList();
    }
    moreDataAvailable = json['moreDataAvailable'];
    nextCursor = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data?.map((e)=>e.toJson()).toList();
    _data['moreDataAvailable'] = moreDataAvailable;
    _data['nextCursor'] = nextCursor;
    return _data;
  }
}

class EquipesData {


  String? id;
  String? nom;
  int? numeroJoueurs;
  List<dynamic>? joueurs;
  List<dynamic>? attenteJoueurs;
  // String? capitaineId;
  DataJoueurModel? capitaineId;
  List<dynamic>? tournois;
  String? wilaya;
  String? createdAt;
  String? updatedAt;
  int? _V;

  EquipesData.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    nom = json['nom'];
    numeroJoueurs = json['numero_joueurs'];
    joueurs = List.castFrom<dynamic, dynamic>(json['joueurs']);
    attenteJoueurs = List.castFrom<dynamic, dynamic>(json['attente_joueurs']);
    capitaineId = json['capitaine_id'] is Map ? DataJoueurModel.fromJson(json['capitaine_id']) : null;
    // capitaineId = json['capitaine_id'];
    tournois = List.castFrom<dynamic, dynamic>(json['tournois']);
    wilaya = json['wilaya'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['numero_joueurs'] = numeroJoueurs;
    _data['joueurs'] = joueurs;
    _data['attente_joueurs'] = attenteJoueurs;
    // _data['capitaine_id'] = capitaineId;
    _data['capitaine_id'] = capitaineId?.toJson();
    _data['tournois'] = tournois;
    _data['wilaya'] = wilaya;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = _V;
    return _data;
  }
}