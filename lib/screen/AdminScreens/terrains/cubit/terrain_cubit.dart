import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'dart:convert' as convert;

part 'terrain_state.dart';

class TerrainCubit extends Cubit<TerrainState> {
  TerrainCubit() : super(TerrainInitial());

  static TerrainCubit get(context) => BlocProvider.of<TerrainCubit>(context);

// TerrainHomeScreen-----------------------------------------------------------------
  List<TerrainModel> terrains = [];
  Future<void> getMyTerrains() async {
    emit(GetMyTerrainsLoading());
    await Httplar.httpget(path: GETMYTERRAINS).then((value) {
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

// -----------------------------------------------------------------------------------
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

  void checkUserById({required String id}) {
    emit(LoadinCheckUserByIdState());
    Httplar.httpget(
      path: getJouerById + id,
    ).then((value) {
      print(getJouerById + id);
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        // emit(TerrainViewToggled());

        emit(CheckUserByIdStateGood(
            dataJoueurModel: DataJoueurModel.fromJson(jsonResponse)));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(CheckUserByIdStateBad());
    });
  }

// Add to your TerrainCubit class

  DateTime selectedDate = DateTime.now();

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(TerrainDateChanged());
  }

  List<String> generateTimeSlots(
      String sTemps, String eTemps, List<dynamic> nonReservable) {
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

    return timeSlots;
  }
}
