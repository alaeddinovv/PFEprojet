import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'package:pfeprojet/Model/reservation.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'dart:convert' as convert;

import 'package:pfeprojet/Model/user_model.dart';

part 'terrain_state.dart';

class TerrainCubit extends Cubit<TerrainState> {
  TerrainCubit() : super(TerrainInitial());

//?---------------------------------------- TerrainHomeScreen-----------------------------------------------------------------

  static TerrainCubit get(context) => BlocProvider.of<TerrainCubit>(context);

  List<TerrainModel> terrains = [];
  Future<void> getMyTerrains() async {
    emit(GetMyTerrainsLoading());
    await Httplar.httpget(path: GETAllTerrain).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;
        terrains =
            jsonResponse.map((item) => TerrainModel.fromJson(item)).toList();

        emit(GetMyTerrainsStateGood()); // Pass the list here
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorTerrainsState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyTerrainsStateBad());
    });
  }

//? -----------------------------------------Details.dart------------------------------------------
  DateTime selectedDate = DateTime.now();

  int indexSlide = 0;
  void setCurrentSlide(int index) {
    indexSlide = index;
    emit(TerrainSlideChanged());
  }

  bool showStadiumDetails =
      false; // false = show reservation grid, true = show stadium details

  void toggleView(int index) {
    bool desiredState = index ==
        1; // Assuming 0 is for the reservation grid and 1 is for stadium details
    if (showStadiumDetails != desiredState) {
      showStadiumDetails = desiredState;
      emit(TerrainViewToggled());
    }
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(TerrainDateChangedState());
  }

  List<String> generateTimeSlots(
    String sTemps,
    String eTemps,
  ) {
    DateTime startTime = DateFormat("HH:mm")
        .parse(sTemps); // time format from server is HH:mm string
    DateTime endTime = DateFormat("HH")
        .parse(eTemps); // time format from server is HH:mm string
    List<String> timeSlots = [];

    while (startTime.isBefore(endTime)) {
      String slot = DateFormat('HH:mm').format(startTime);
      timeSlots.add(slot);
      startTime = startTime.add(const Duration(hours: 1, minutes: 0));
    }
    // print(timeSlots);
    return timeSlots;
  }

  List<ReservationModel> reservationList = [];
  Future<void> fetchReservations(
      {bool payment = true,
      required String terrainId,
      required DateTime date,
      String heure_debut_temps = ""}) async {
    emit(GetReservationLoadingState());
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    await Httplar.httpget(path: FILTERRESERVATION, query: {
      "payment": payment.toString(),
      "terrain_id": terrainId,
      "jour": formattedDate,
      if (heure_debut_temps.isNotEmpty) "heure_debut_temps": heure_debut_temps
    }).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;
        // print(jsonResponse);
        reservationList = jsonResponse
            .map((item) => ReservationModel.fromJson(item))
            .toList();
        emit(GetReservationStateGood(reservations: reservationList));
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

  // ?-----------------------------------------Reserve.dart------------------------------------------

  Future<void> addReservation({
    Map<String, dynamic>? model,
    String? idTerrain,
  }) async {
    emit(AddReservationLoadingState());
    await Httplar.httpPost(path: ReservationJoueur + idTerrain!, data: model!)
        .then((value) {
      if (value.statusCode == 201) {
        emit(AddReservationStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
        print(jsonResponse.toString());
      }
    }).catchError((e) {
      print(e.toString());
      emit(AddReservationStateBad());
    });
  }
}
