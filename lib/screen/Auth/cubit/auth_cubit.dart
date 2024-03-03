import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'package:pfeprojet/Model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  Icon iconhidden = const Icon(Icons.visibility);
  bool ishidden = true;
  void showpass() {
    if (ishidden) {
      iconhidden = const Icon(Icons.visibility_off);
      ishidden = !ishidden;
    } else {
      iconhidden = const Icon(Icons.visibility);
      ishidden = !ishidden;
    }
    emit(PasswordHiddenState());
  }

  UserModel? registerModel;
  ErrorModel? errorRegisterModel;

  void registerUser({required Map<String, dynamic> data}) {
    emit(RegisterLodinState());

    Httplar.httpPost(path: REGISTERJOUER, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        registerModel = UserModel.fromJson(jsonResponse);
        emit(RegisterStateGood(model: registerModel!));
      } else if (value.statusCode == 400) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        errorRegisterModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(errorModel: errorRegisterModel!));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterStateBad());
    });
  }

  UserModel? joueurModel;
  AdminModel? adminModel;

  ErrorModel? errorloginModel;
  void login({required Map<String, dynamic> data, required String path}) {
    emit(LoginLoadingState());
    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        if (path == Loginadmin) {
          adminModel = AdminModel.fromJson(jsonResponse);
          emit(LoginStateGood(model: adminModel!));
        } else if (path == Loginjoueur) {
          joueurModel = UserModel.fromJson(jsonResponse);
          emit(LoginStateGood(model: joueurModel!));
        }
      } else if (value.statusCode == 400 ||
          value.statusCode == 401 ||
          value.statusCode == 404) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        errorRegisterModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(errorModel: errorRegisterModel!));
      }
    }).catchError((e) {
      print(e.toString());
      emit(LoginStateBad());
    });
  }
}
