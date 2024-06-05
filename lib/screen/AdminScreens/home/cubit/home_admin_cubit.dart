import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/annonce.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/reservation.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/screen/AdminScreens/terrains/terrains.dart';

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit() : super(HomeAdminInitial());
  static HomeAdminCubit get(context) => BlocProvider.of(context);
  final List<Widget> body = [
    const Terrains(),
    Reservation(),
    const Annonce(),
  ];
  final List<String> title = [
    "Terrains",
    "Reservation",
    "Annonce",
  ];

  void resetValue() {
    selectedIndex = 0;
    adminModel = DataAdminModel();

    emit(ResetValueHomeState());
  }

  int selectedIndex = 0;
  void changeIndexNavBar(int index) {
    selectedIndex = index;
    emit(ChangeIndexNavBarState());
  }

  DataAdminModel? adminModel;

  setAdminModel(DataAdminModel adminModel) {
    this.adminModel = adminModel;
    emit(UpdateAdminModelVariable());
  }

  Future<void> getMyInfo() async {
    emit(GetMyInformationLoading());
    await Httplar.httpget(path: GETMYINFORMATIONADMIN).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        adminModel = DataAdminModel.fromJson(jsonResponse);
        emit(GetMyInformationStateGood(model: adminModel!));
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
