import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pfeprojet/component/const.dart';

part 'terrain_state.dart';

class TerrainCubit extends Cubit<TerrainState> {
  TerrainCubit() : super(TerrainInitial());

  static TerrainCubit get(context) => BlocProvider.of<TerrainCubit>(context);

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
}
