class UserProfile {
  String name;
  String skillLevel;
  int age;
  int height;
  int weight;
  int exerciseDays = 0;
  Map<int, Map<int, int>> _workoutDates = {
    2023: {
      11: 23,
    },
  };

  Map<String, double> _weeklyCalorieBurned = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thur': 0,
    'Frid': 0,
    'Sat': 0,
    'Sun': 0,
  };

  UserProfile({
    required this.age,
    required this.height,
    required this.weight,
    required this.name,
    required this.skillLevel,
  });

  String get bmi {
    return ((weight) / ((height / 100) * (height / 100))).toStringAsFixed(2);
  }

  double get heightMeters {
    return height / 100;
  }

  void updateCalorieBurned(String key, double value) {
    _weeklyCalorieBurned[key] = value;
  }

  void workoutDataInitialize(
    Map<int, Map<int, int>> workoutDates,
    Map<String, double> weeklyCaloriesBurned,
  ) {
    _workoutDates = workoutDates;
    _weeklyCalorieBurned = weeklyCaloriesBurned;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'skill_level': skillLevel,
      'age': age,
      'height': height,
      'weight': weight,
      'exercise_days': exerciseDays,
      'workout_dates': _workoutDates,
      'weekly_calories_burned': _weeklyCalorieBurned,
    };
  }
}
