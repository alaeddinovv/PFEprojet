import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Model/reservation_pagination_model.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(ReservationInitial());
  static ReservationCubit get(context) => BlocProvider.of(context);
  String cursorId = "";

  List<ReservationPaginationModelData> reservationList = [];
  Future<void> fetchReservations(
      {String cursor = '',
      // required String terrainId,
      // required DateTime date,
      String heure_debut_temps = ""}) async {
    emit(GetReservationLoadingState());
    // String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    await Httplar.httpget(path: '$FILTERRESERVATIONPagination', query: {
      // "terrain_id": terrainId,
      "payment": "false",
      "cursor": cursor,
      // "jour": formattedDate,
      // if (heure_debut_temps.isNotEmpty) "heure_debut_temps": heure_debut_temps
    }).then((value) {
      if (value.statusCode == 200) {
        if (cursor == "") {
          reservationList = [];
          cursorId = "";
        }
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ReservationPaginationModel model =
            ReservationPaginationModel.fromJson(jsonResponse);
        reservationList.addAll(model.data!);
        cursorId = model.nextCursor!;

        emit(GetReservationStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());

      emit(GetReservationStateBad());
    });
  }
}
