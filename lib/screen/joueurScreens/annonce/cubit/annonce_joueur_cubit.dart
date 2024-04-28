import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/annonce_model.dart';

import '../../../../Model/annonce_admin_model.dart';
import '../../../../Model/error_model.dart';

part 'annonce_joueur_state.dart';

class AnnonceJoueurCubit extends Cubit<AnnonceJoueurState> {
  AnnonceJoueurCubit() : super(AnnonceJoueurInitial());

  static AnnonceJoueurCubit get(context) => BlocProvider.of<AnnonceJoueurCubit>(context);

  // creer annonce -----------------------------------------------------------------------
  Future<void> creerAnnonceJoueur(
      {required String type, required String text, String? wilaya, String? commune}) async {
    emit(CreerAnnonceJoueurLoadingState());

    Map<String, dynamic> _model = {
      "type": type,
      "description": text,
      "wilaya": wilaya,
      "commune": commune
    };

    await Httplar.httpPost(path: ADDANNONCE, data: _model).then((value) {
      if (value.statusCode == 201) {
        emit(CreerAnnonceJoueurStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
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
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
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
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteAnnonceJoueurStateBad());
    });
  }

  //update annonce  -----------------------------------------------------------------------

  Future<void> updateAnnonceJoueur({
    required String id,
    required String type,
    required String description,  String? wilaya, String? commune
  }) async {
    emit(UpdateAnnonceJoueurLoadingState());

    Map<String, dynamic> _model = {
      "type": type,
      "description": description,
      "wilaya": wilaya,
      "commune": commune
    };
    await Httplar.httpPut(path: UPDATEANNONCE + id, data: _model).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateAnnonceJoueurStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
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
  Future<void> getAllAnnonce({String cursor = ''}) async {
    emit(GetAllAnnonceLoading());
    print('1');
    await Httplar.httpget(path: GETALLANNONCE, query: {'cursor': cursor})
        .then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          annonces = [];
          cursorid = "";
        }

        print('1');
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;

        print('1');
        AnnonceModel model = AnnonceModel.fromJson(jsonResponse);
        annonces.addAll(model.data!);
        cursorid = model.nextCursor!;

        print(annonces);

        emit(GetAllAnnonceStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllAnnonceStateBad());
    });
  }







}
