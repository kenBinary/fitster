class UserProfile {
  String name;
  String skillLevel;
  int age;
  int height;
  int weight;
  int exerciseDays = 0;

  Map<String, double> weeklyCalorieBurned = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thur': 0,
    'Frid': 0,
    'Sat': 0,
    'Sun': 0,
  };

  UserProfile(
    this.age,
    this.height,
    this.weight,
    this.name,
    this.skillLevel,
  );

  String get bmi {
    return ((weight) / ((height / 100) * (height / 100))).toStringAsFixed(2);
  }

  double get heightMeters {
    return height / 100;
  }

  void updateCalorieBurned(String key, double value) {
    weeklyCalorieBurned[key] = value;
  }
}