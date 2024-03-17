import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'terrain_state.dart';

class TerrainCubit extends Cubit<TerrainState> {
  TerrainCubit() : super(TerrainInitial());
  static TerrainCubit get(context) => BlocProvider.of<TerrainCubit>(context);

  int indexSlide = 0;
  void setCurrentSlide(int index) {
    indexSlide = index;
    emit(TerrainSlideChanged());
  }

  DateTime? dateSelected;
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
  final List<DateTime> dates =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  List<String> timeSlots = [
    "8:00",
    "9:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "24:00"
  ];
}
