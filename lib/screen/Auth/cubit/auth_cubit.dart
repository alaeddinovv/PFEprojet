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

  Icon iconhidden = const Icon(Icons.visibility_outlined);
  bool ishidden = true;
  bool checkBox = false;
  void changeCheckBox() {
    checkBox = !checkBox;
    emit(CheckBoxState());
  }

  void showpass() {
    if (ishidden) {
      iconhidden = const Icon(Icons.visibility_off_outlined);
      ishidden = !ishidden;
    } else {
      iconhidden = const Icon(Icons.visibility_outlined);
      ishidden = !ishidden;
    }
    emit(PasswordHiddenState());
  }

  // UserModel? registerModel;
  // ErrorModel? errorRegisterModel;

  void registerUser({required Map<String, dynamic> data}) {
    emit(RegisterLodinState());

    Httplar.httpPost(path: REGISTERJOUER, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(RegisterStateGood(model: UserModel.fromJson(jsonResponse)));
      } else if (value.statusCode == 400) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterStateBad());
    });
  }

  // UserModel? joueurModel;
  // AdminModel? adminModel;

  ErrorModel? errorloginModel;
  void login({required Map<String, dynamic> data, required String path}) {
    emit(LoginLoadingState());
    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        if (path == Loginadmin) {
          emit(LoginStateGood(model: AdminModel.fromJson(jsonResponse)));
        } else if (path == Loginjoueur) {
          emit(LoginStateGood(model: UserModel.fromJson(jsonResponse)));
        }
      } else if (value.statusCode == 400 ||
          value.statusCode == 401 ||
          value.statusCode == 404) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(LoginStateBad());
    });
  }
}
