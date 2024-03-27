import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/error_model.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'package:pfeprojet/component/const.dart';
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

  final List<Map<String, dynamic>> timeSlots = [
    {"time": "8:00", "isReserved": true},
    {"time": "9:00", "isReserved": false},
    {"time": "10:00", "isReserved": true},
    {"time": "11:00", "isReserved": false},
    {"time": "12:00", "isReserved": false},
    {"time": "13:00", "isReserved": true},
    {"time": "14:00", "isReserved": false},
    {"time": "15:00", "isReserved": false},
    {"time": "16:00", "isReserved": false},
    {"time": "17:00", "isReserved": false},
    {"time": "18:00", "isReserved": false},
    {"time": "19:00", "isReserved": false},
    {"time": "20:00", "isReserved": false},
    {"time": "21:00", "isReserved": false},
    {"time": "22:00", "isReserved": false},
    {"time": "23:00", "isReserved": false},
    {"time": "24:00", "isReserved": false}
  ];

  DateTime dateSelected = dates.first;

  void setSelectedDate(DateTime date) {
    dateSelected = date;
    emit(TerrainDateChanged());
  }

  final List<String> assetImagePaths = [
    'assets/images/terrain2.jpg',
    'assets/images/terrain.png',
    'assets/images/terrain2.jpg',
    'assets/images/terrain.png',
  ];

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
}
