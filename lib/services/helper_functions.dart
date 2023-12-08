double getMetValue({required int totalReps}) {
  if (totalReps <= 12) {
    return 5;
  } else if (totalReps > 12 && totalReps <= 24) {
    return 10;
  } else {
    return 15;
  }
}

double caloriesBurnedPerMinute({
  required double metValue,
  required double weight,
}) {
  return ((3.5 * metValue * weight) / 200);
}

double totalCaloriesBurned({
  required int totalReps,
  required double weight,
}) {
  double metValue = getMetValue(totalReps: totalReps);
  return caloriesBurnedPerMinute(metValue: metValue, weight: weight) * 5;
}

List<String> getCurrentWeek() {
  List<String> week = [];
  DateTime currentDay = DateTime.now();
  for (var i = 1; i <= 7; i++) {
    DateTime date =
        DateTime.now().subtract(Duration(days: currentDay.weekday - i));
    week.add('${date.year}-${date.month}-${date.day}');
  }
  return week;
}

String formatDateString(String date) {
  String newString = '';
  final x = (date.split('-')).map((element) {
    if (element.length == 1) {
      return '0$element';
    }
    return element;
  }).toList();
  newString = x.join('-');
  return newString;
}
