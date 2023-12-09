import 'dart:math';

String getRandomExerciseCardImage() {
  Random random = Random();
  List<String> images = [
    'assets/ExerciseCardImages/exercise_1.png',
    'assets/ExerciseCardImages/exercise_2.png',
    'assets/ExerciseCardImages/exercise_3.png',
    'assets/ExerciseCardImages/exercise_4.png',
    'assets/ExerciseCardImages/exercise_5.png',
    'assets/ExerciseCardImages/exercise_6.png',
    'assets/ExerciseCardImages/exercise_7.png',
    'assets/ExerciseCardImages/exercise_8.png',
    'assets/ExerciseCardImages/exercise_9.png',
    'assets/ExerciseCardImages/exercise_10.png',
  ];
  return images[random.nextInt(10)];
}

String getRandomMuscleGroupImage() {
  Random random = Random();
  List<String> images = [
    'assets/muscle_groups/arms.png',
    'assets/muscle_groups/back.png',
    'assets/muscle_groups/chest.png',
    'assets/muscle_groups/legs.png',
    'assets/muscle_groups/push.png',
    'assets/muscle_groups/upper.png',
  ];
  return images[random.nextInt(6)];
}
