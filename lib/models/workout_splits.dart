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
}

class WorkoutSplit {
  String name;
  int daysOfWeek;
  List<MuscleGroup> muscleGroups;

  WorkoutSplit({
    required this.name,
    required this.daysOfWeek,
    required this.muscleGroups,
  });
}

class PushPullLegsSplit extends WorkoutSplit {
  PushPullLegsSplit({
    required String name,
    required int daysOfWeek,
    required List<MuscleGroup> muscleGroups,
  }) : super(
          name: name,
          daysOfWeek: daysOfWeek,
          muscleGroups: muscleGroups,
        );
}

class BroSplit extends WorkoutSplit {
  BroSplit({
    required String name,
    required int daysOfWeek,
    required List<MuscleGroup> muscleGroups,
  }) : super(
          name: name,
          daysOfWeek: daysOfWeek,
          muscleGroups: muscleGroups,
        );
}

class UpperLowerSplit extends WorkoutSplit {
  UpperLowerSplit({
    required String name,
    required int daysOfWeek,
    required List<MuscleGroup> muscleGroups,
  }) : super(
          name: name,
          daysOfWeek: daysOfWeek,
          muscleGroups: muscleGroups,
        );
}
