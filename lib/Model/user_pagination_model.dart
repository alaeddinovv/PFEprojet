import 'package:pfeprojet/Model/user_model.dart';

class UserPaginationModel {
  List<DataJoueurModel>? data;
  bool? moreDataAvailable;
  String? nextCursor;
  int? currentPage;

  UserPaginationModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => DataJoueurModel.fromJson(e))
        .toList();
    moreDataAvailable = json['moreDataAvailable'];
    nextCursor = json['nextCursor'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.map((e) => e.toJson()).toList();
    _data['moreDataAvailable'] = moreDataAvailable;
    _data['nextCursor'] = nextCursor;
    _data['currentPage'] = currentPage;
    return _data;
  }
}
