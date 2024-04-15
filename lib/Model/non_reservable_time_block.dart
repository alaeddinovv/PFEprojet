class NonReservableTimeBlock {
  String day;
  List<String> hours;

  NonReservableTimeBlock({required this.day, required this.hours});

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'hours': hours,
    };
  }
}
