import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'package:pfeprojet/Model/houssem/equipe_model.dart';
import 'dart:convert' as convert;

part 'reservation_state.dart';

class ReservationJoueurCubit extends Cubit<ReservationJoueurState> {
  ReservationJoueurCubit() : super(ReservationInitial());
  static ReservationJoueurCubit get(context) =>
      BlocProvider.of<ReservationJoueurCubit>(context);
  void resetValue() {
    equipesdemander = [];
    cursorid = "";
    emit(ResetReservationJoueurState());
  }

  List<EquipeModelData> equipesdemander = [];
  String cursorid = "";
  Future<void> getEquipesDemander({String cursor = '', String? owner}) async {
    emit(GetAllEquipeDemanderLoading());
    await Httplar.httpget(
        path: GETALLEQUIPEDEMEANDER, query: {'cursor': cursor}).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          equipesdemander = [];
          cursorid = "";
        }

        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        // print(jsonResponse);
        EquipeModel model = EquipeModel.fromJson(jsonResponse);

        equipesdemander.addAll(model.data!);
        cursorid = model.nextCursor!;

        // print(equipesdemander);

        emit(GetAllEquipeDemanderStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllEquipeDemanderStateBad());
    });
  }
}
