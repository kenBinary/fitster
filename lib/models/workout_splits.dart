class Exercise {
  String name;
  int sets;
  int reps;
  int restTime;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.restTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'rest_time': restTime,
    };
  }
}

class MuscleGroup {
  String group;
  List<Exercise> exercises;
  MuscleGroup({
    required this.group,
    required this.exercises,
  });

  void addExercise(Exercise exercise) {}

  void removeExercise(Exercise exercise) {}

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> exerciseList = [];
    for (Exercise exercise in exercises) {
      exerciseList.add(exercise.toJson());
    }
    return {
      'group': group,
      'exercises': exerciseList,
    };
  }
}

class WorkoutSplit {
  String name;
  int daysOfWeek;
  List<MuscleGroup> muscleGroups;
  List<String> targetMuscles;

  WorkoutSplit({
    required this.name,
    required this.daysOfWeek,
    required this.muscleGroups,
    required this.targetMuscles,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> muscleGroupList = [];
    for (MuscleGroup muscleGroup in muscleGroups) {
      muscleGroupList.add(muscleGroup.toJson());
    }
    Map<String, dynamic> myMap = {
      'workout_split': {
        'days_of_week': '7',
        'name': name,
        'target_muscles': targetMuscles,
      },
      'muscle_group': muscleGroupList,
    };
    return myMap;
  }
}

class PushPullLegsSplit extends WorkoutSplit {
  PushPullLegsSplit({
    required String name,
    required int daysOfWeek,
    required List<MuscleGroup> muscleGroups,
    required List<String> targetMuscles,
  }) : super(
          name: name,
          daysOfWeek: daysOfWeek,
          muscleGroups: muscleGroups,
          targetMuscles: targetMuscles,
        );
}

class BroSplit extends WorkoutSplit {
  BroSplit({
    required String name,
    required int daysOfWeek,
    required List<MuscleGroup> muscleGroups,
    required List<String> targetMuscles,
  }) : super(
          name: name,
          daysOfWeek: daysOfWeek,
          muscleGroups: muscleGroups,
          targetMuscles: targetMuscles,
        );
}

class UpperLowerSplit extends WorkoutSplit {
  UpperLowerSplit({
    required String name,
    required int daysOfWeek,
    required List<MuscleGroup> muscleGroups,
    required List<String> targetMuscles,
  }) : super(
          name: name,
          daysOfWeek: daysOfWeek,
          muscleGroups: muscleGroups,
          targetMuscles: targetMuscles,
        );
}
