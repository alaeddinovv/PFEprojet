import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/Model/equipes_model.dart';


import '../../../../Model/error_model.dart';

part 'equipe_state.dart';

class EquipeCubit extends Cubit<EquipeState> {
  EquipeCubit() : super(EquipeInitial());

  static EquipeCubit get(context) => BlocProvider.of<EquipeCubit>(context);
//------------------ equipe creer---------------------
  Future<void> creerEquipe(
      {required String nom,
        required String numero_joueurs,
        String? wilaya}) async {
    emit(CreerEquipeLoadingState());

    Map<String, dynamic> _model = {
      "nom": nom,
      "numero_joueurs": numero_joueurs,
      "wilaya": wilaya
    };

    await Httplar.httpPost(path: ADDEQUIPE, data: _model).then((value) {
      if (value.statusCode == 201) {
        emit(CreerEquipeStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CreerEquipeStateBad());
    });
  }
  //----------------- get my terrain--------------------
  List<EquipeData> equipeData = [];
  String cursorId = "";
  Future<void> getMyEquipe({String cursor = ''}) async {
    emit(GetMyEquipeLoading());

    await Httplar.httpget(path: GETMYEQUIPE, query: {'cursor': cursor})
        .then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipeData = [];
          cursorId = "";
        }
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        EquipeModel model = EquipeModel.fromJson(jsonResponse);
        equipeData.addAll(model.data!);
        cursorId = model.nextCursor!;
        print(jsonResponse['nom']);
        emit(GetMyEquipeStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyEquipeStateBad());
    });
  }
  //-------------------------delete equipe ---------------------------------
  Future<void> deleteEquipe({required String id}) async {
    emit(DeleteEquipeLoadingState());

    await Httplar.httpdelete(path: DELETEEQUIPE + id).then((value) {
      if (value.statusCode == 204) {
        emit(DeleteEquipeStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteEquipeStateBad());
    });
  }
  //----------------- update equipe -------------------------------
  Future<void> updateEquipe(
      {
        required String id,
        required String nom,
        required String numero_joueurs,

        String? wilaya
        }) async {
    emit(UpdateEquipeLoadingState());

    Map<String, dynamic> _model = {
      "nom": nom,
      "numero_joueurs": numero_joueurs,
      "wilaya": wilaya
    };
    await Httplar.httpPut(path: UPDATEEQUIPE + id, data: _model).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateEquipeStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateEquipeStateBad());
    });
  }
  //-------------------- get all equipes ----------------------------
  List<EquipesData> equipes = [];
  // cusrsorid mdeclari lfug
  String cursorid = "";
  Future<void> getAllEquipe({String cursor = ''}) async {
    emit(GetAllEquipeLoading());
    print('1');
    await Httplar.httpget(path: GETALLEQUIPE, query: {'cursor': cursor})
        .then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipes = [];
          cursorid = "";
        }

        print('1');
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;

        print('1');
        EquipesModel model = EquipesModel.fromJson(jsonResponse);
        equipes.addAll(model.data!);
        cursorid = model.nextCursor!;

        print(equipes);

        emit(GetAllEquipeStateGood());
      } else {
        var jsonResponse =
        convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllEquipeStateBad());
    });
  }


}
