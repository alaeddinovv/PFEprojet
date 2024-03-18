var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};

String formatWeekdayDate(DateTime dateTime) {
  // These arrays represent the weekdays and months in French.
  const weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  const months = [
    'Jan',
    'Fév',
    'Mar',
    'Avr',
    'Mai',
    'Jun',
    'Jul',
    'Aoû',
    'Sep',
    'Oct',
    'Nov',
    'Déc'
  ];

  // Get the weekday and month as a string.
  String weekday = weekdays[dateTime.weekday - 1];
  String month = months[dateTime.month - 1];

  // Return the formatted date.
  return '$weekday, ${dateTime.day} $month';
}
