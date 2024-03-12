import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'dart:convert' as convert;

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit() : super(HomeAdminInitial());
  static HomeAdminCubit get(context) => BlocProvider.of(context);
  DataAdminModel? adminModel;
  // ErrorModel? errorGetMyInfoModel;

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
