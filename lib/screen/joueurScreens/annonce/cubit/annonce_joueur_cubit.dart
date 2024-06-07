import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/annonce/annonce_model.dart';
import 'package:pfeprojet/Model/annonce/pulier/annonce_other_model.dart';
import 'package:pfeprojet/Model/annonce/pulier/annonce_search_model.dart';
import 'package:pfeprojet/Model/terrain_pagination_model.dart';
import 'package:pfeprojet/helper/cachhelper.dart';

import '../../../../Model/annonce/annonce_admin_model.dart';
import '../../../../Model/error_model.dart';

part 'annonce_joueur_state.dart';

class AnnonceJoueurCubit extends Cubit<AnnonceJoueurState> {
  AnnonceJoueurCubit() : super(AnnonceJoueurInitial());

  void resetValue() {
    annonceData = [];
    cursorId = "";
    annonces = [];
    cursorid = "";
    terrainSearch = [];
    cursorIdTerrain = "";
    emit(ResetAnnonceJoueurState());
  }

  static AnnonceJoueurCubit get(context) =>
      BlocProvider.of<AnnonceJoueurCubit>(context);

  // creer annonce -----------------------------------------------------------------------
  Future<void> creerAnnonceJoueur({required Map<String, dynamic> model}) async {
    emit(CreerAnnonceJoueurLoadingState());

    // Map<String, dynamic> _model = {
    //   "type": type,
    //   "description": description,
    //   "wilaya": wilaya,
    //   "commune": commune
    // };

    await Httplar.httpPost(path: ADDANNONCE, data: model).then((value) {
      if (value.statusCode == 201) {
        emit(CreerAnnonceJoueurStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateAnnonce(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CreerAnnonceJoueurStateBad());
    });
  }

  //get My annonce  -----------------------------------------------------------------------

  List<AnnonceAdminData> annonceData = [];
  String cursorId = "";
  Future<void> getMyAnnonceJoueur({String cursor = ''}) async {
    emit(GetMyAnnonceJoueurLoading());
    await Httplar.httpget(path: GETMYANNONCEJOUEUR, query: {'cursor': cursor})
        .then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          annonceData = [];
          cursorId = "";
        }
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        AnnonceAdminModel model = AnnonceAdminModel.fromJson(jsonResponse);
        annonceData.addAll(model.data!);
        cursorId = model.nextCursor!;
        print(annonceData);
        emit(GetMyAnnonceJoueurStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse.toString());
        emit(ErrorStateAnnonce(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyAnnonceJoueurStateBad());
    });
  }

  //delete annonce  -----------------------------------------------------------------------

  Future<void> deleteAnnonceJoueur({required String id}) async {
    emit(DeleteAnnonceJoueurLoadingState());

    await Httplar.httpdelete(path: DELETEANNONCE + id).then((value) {
      if (value.statusCode == 204) {
        emit(DeleteAnnonceJoueurStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateAnnonce(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteAnnonceJoueurStateBad());
    });
  }

  //update annonce  -----------------------------------------------------------------------

  Future<void> updateAnnonceJoueur(
      {required Map<String, dynamic> model, required String id}) async {
    emit(UpdateAnnonceJoueurLoadingState());

    await Httplar.httpPut(path: UPDATEANNONCE + id, data: model).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateAnnonceJoueurStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateAnnonce(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateAnnonceJoueurStateBad());
    });
  }

  //-----------------------------------

  List<AnnonceData> annonces = [];
  // cusrsorid mdeclari lfug
  String cursorid = "";
  Future<void> getAllAnnonce(
      {String cursor = '', String? myId, String? createur}) async {
    emit(GetAllAnnonceLoading());
    print('1');
    await Httplar.httpPost(
        data: {"idList": CachHelper.getData(key: 'suggestionId')},
        path: GETALLANNONCE,
        query: {'cursor': cursor, "createur": createur}).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          annonces = [];
          cursorid = "";
        }

        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;

        AnnonceModel model = AnnonceModel.fromJson(jsonResponse);
        model.data!.forEach((element) {
          print(element.description);
          // print(element.joueur!.id);
          if (element.joueur?.id != myId) {
            annonces.add(element);
          }
        });
        // annonces.addAll(model.data!);
        cursorid = model.nextCursor!;

        print(annonces);

        emit(GetAllAnnonceStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateAnnonce(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllAnnonceStateBad());
    });
  }

  Future<void> getAnnonceByID({
    required String id,
  }) async {
    emit(GetAnnonceByIDLoading());
    await Httplar.httpget(path: GETANNONCEBYID + id).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse['type']);
        print(jsonResponse);
        if (jsonResponse['type'] == 'search joueur') {
          AnnonceSearchJoueurModel annonce =
              AnnonceSearchJoueurModel.fromJson(jsonResponse);
          print(annonce);
          emit(GetAnnonceByIDStateGood(annonceModel: annonce));
        } else {
          print(jsonResponse);
          AnnounceOter annonce2 = AnnounceOter.fromJson(jsonResponse);
          emit(GetAnnonceByIDStateGood(annonceModel: annonce2));
        }
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateAnnonce(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAnnonceByIDStateBad());
    });
  }

  List<TarrainPaginationData> terrainSearch = [];
  String cursorIdTerrain = "";

  Future<void> searchTerrain(
      {String cursor = '', String? nomTerrain, required bool isOnlyMy}) async {
    emit(GetSearchTerrainLoading());
    if (nomTerrain == '') {
      terrainSearch = [];
      cursorIdTerrain = "";
      return;
    }
    String pathSearch;
    if (isOnlyMy) {
      pathSearch = SEARCHMYTERRAIN;
    } else {
      pathSearch = SEARCHTERRAIN;
    }
    await Httplar.httpget(
        path: pathSearch,
        query: {'cursor': cursor, 'nom': nomTerrain}).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          terrainSearch = [];
          cursorIdTerrain = "";
        }
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        TerrainPaginationModel model =
            TerrainPaginationModel.fromJson(jsonResponse);
        terrainSearch.addAll(model.data);
        print(terrainSearch.length);
        cursorIdTerrain = model.nextCursor;
        print(cursorIdTerrain);

        emit(GetSearchTerrainStateGood()); // Pass the list here
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateSerchTerrain(
            errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetSearchTerrainStateBad());
    });
  }

  Future<void> demanderRejoindreEquipe(
      {required String joueurId,
      required String userName,
      required String equipeId,
      required String post,
      required String nameEquipe}) async {
    emit(DemandeRejoindreEquipeLoadingState());
    print(equipeId);
    await Httplar.httpPost(path: DEMANDERREJOINDREEQUIPE + equipeId, data: {
      "post": post,
    }).then((value) {
      if (value.statusCode == 200) {
        emit(DemandeRejoindreEquipeStateGood(
            userName: userName,
            equipeName: nameEquipe,
            joueurId: joueurId,
            post: post));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorStateDemanderRejoinderEquipe(
            errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DemandeRejoindreEquipeInvStateBad());
    });
  }
}
