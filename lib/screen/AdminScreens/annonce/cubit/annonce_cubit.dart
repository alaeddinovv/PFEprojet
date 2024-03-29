import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';

import '../../../../Model/annonce_model.dart';
import '../../../../Model/error_model.dart';

part 'annonce_state.dart';

class AnnonceCubit extends Cubit<AnnonceState> {
  AnnonceCubit() : super(AnnonceInitial());

  static AnnonceCubit get(context) => BlocProvider.of<AnnonceCubit>(context);

  AnnonceModel? annonceModel;
  // ---------------creer annonce
  Future<void> creerAnnonce(
      {required String type, required String text}) async {
    emit(CreerAnnonceLoadingState());

    Map<String, dynamic> _model = {
      "type": type,
      "description": text,
    };

    await Httplar.httpPost(path: ADDANNONCE, data: _model).then((value) {
      if (value.statusCode == 201) {
        emit(CreerAnnonceStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CreerAnnonceStateBad());
    });
  }

  //get My annonce  -----------------------------------------------------------------------

  Future<void> getMyAnnonce() async {
    emit(GetMyAnnonceLoading());
    await Httplar.httpget(path: GETMYANNONCE).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;

        List<AnnonceModel> annonces =
            jsonResponse.map((item) => AnnonceModel.fromJson(item)).toList();
        emit(GetMyAnnonceStateGood(annonces: annonces)); // Pass the list here
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyAnnonceStateBad());
    });
  }

  Future<void> deleteAnnonce({required String id}) async {
    emit(DeleteAnnonceLoadingState());

    await Httplar.httpdelete(path: DELETEANNONCE + id).then((value) {
      if (value.statusCode == 204) {
        emit(DeleteAnnonceStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteAnnonceStateBad());
    });
  }

  Future<void> updateAnnonce({
    required String id,
    required String type,
    required String description,
  }) async {
    emit(UpdateAnnonceLoadingState());

    Map<String, dynamic> _model = {
      "type": type,
      "description": description,
    };
    await Httplar.httpPut(path: UPDATEANNONCE + id, data: _model).then((value) {
      if (value.statusCode == 200) {
        emit(UpdateAnnonceStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateAnnonceStateBad());
    });
  }
}
