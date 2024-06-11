import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'package:pfeprojet/Model/error_model.dart';

import 'dart:convert' as convert;

import 'package:pfeprojet/screen/joueurScreens/equipe/equipe.dart';

import '../../annonce/annonce.dart';
import '../../reservation/reservation.dart';
import '../../terrains/terrains.dart';

part 'home_joueur_state.dart';

class HomeJoueurCubit extends Cubit<HomeJoueurState> {
  HomeJoueurCubit() : super(HomeJoueurInitial());
  static HomeJoueurCubit get(context) => BlocProvider.of(context);

  void resetValue() {
    selectedIndex = 0;
    joueurModel = DataJoueurModel();
    emit(ResetHomeState());
  }

  final List<String> title = [
    "Les Terrains",
    "Mes Denmandes",
    "Les Annonces",
    "Les Equipes"
  ];
  final List<String> titleAr = ["الملاعب", "طلباتي", "الإعلانات", "الفرق"];

  final List<Widget> body = [
    const Terrain(),
    const Reservation(),
    const Annonce(),
    Equipe()
  ];

  int selectedIndex = 0;
  void changeIndexNavBar(int index) {
    selectedIndex = index;
    emit(ChangeIndexNavBarState());
  }

  DataJoueurModel? joueurModel;

  Future<void> getMyInfo() async {
    emit(GetMyInformationLoading());
    await Httplar.httpget(path: GETMYINFORMATIONJOUEUR).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        joueurModel = DataJoueurModel.fromJson(jsonResponse);
        emit(GetMyInformationStateGood(model: joueurModel!));
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorHomeState(model: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyInformationStateBad());
    });
  }
}
