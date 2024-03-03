import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Api/httplaravel.dart';
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
  // ErrorRegisterAndLoginModel? errorRegisterModel;
  void registerUser(
      {required Map<String, dynamic> data, required String path}) {
    emit(RegisterLodinState());

    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        registerModel = UserModel.fromJson(jsonResponse);
        print(registerModel!.data!.age);
        emit(RegisterStateGood(model: registerModel!));
      } else if (value.statusCode == 422) {
        print('dfdf');
        // var jsonResponse =
        //     convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);

        emit(RegisterStateBad());
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterStateBad());
    });
  }
}
