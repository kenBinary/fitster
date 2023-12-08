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
