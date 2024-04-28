class ReservationPaginationModel {
  List<ReservationPaginationModelData>? data;
  bool? moreDataAvailable;
  String? nextCursor;

  ReservationPaginationModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => ReservationPaginationModelData.fromJson(e))
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

class ReservationPaginationModelData {
  String? id;
  DateTime? jour;
  String? heureDebutTemps;
  int? duree;
  String? etat;
  bool? payment;
  JoueurId? joueurId;
  TerrainId? terrainId;
  int? V;

  ReservationPaginationModelData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    jour = DateTime.parse(json['jour']);
    heureDebutTemps = json['heure_debut_temps'];
    duree = json['duree'];
    etat = json['etat'];
    payment = json['payment'];
    joueurId = JoueurId.fromJson(json['joueur_id']);
    terrainId = TerrainId.fromJson(json['terrain_id']);
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['jour'] = jour;
    _data['heure_debut_temps'] = heureDebutTemps;
    _data['duree'] = duree;
    _data['etat'] = etat;
    _data['payment'] = payment;
    _data['joueur_id'] = joueurId!.toJson();
    _data['terrain_id'] = terrainId!.toJson();
    _data['__v'] = V;
    return _data;
  }
}

class JoueurId {
  String? id;
  String? username;
  int? telephone;

  JoueurId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['username'] = username;
    _data['telephone'] = telephone;
    return _data;
  }
}

class TerrainId {
  String? id;
  String? nom;

  TerrainId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    return _data;
  }
}
