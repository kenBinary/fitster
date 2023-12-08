import 'dart:math';

String getRandomExerciseCardImage() {
  Random random = Random();
  List<String> images = [
    '../lib/images/ExerciseCardImages/exercise_1.png',
    '../lib/images/ExerciseCardImages/exercise_2.png',
    '../lib/images/ExerciseCardImages/exercise_3.png',
    '../lib/images/ExerciseCardImages/exercise_4.png',
    '../lib/images/ExerciseCardImages/exercise_5.png',
    '../lib/images/ExerciseCardImages/exercise_6.png',
    '../lib/images/ExerciseCardImages/exercise_7.png',
    '../lib/images/ExerciseCardImages/exercise_8.png',
    '../lib/images/ExerciseCardImages/exercise_9.png',
    '../lib/images/ExerciseCardImages/exercise_10.png',
  ];
  return images[random.nextInt(10)];
}

void main(List<String> args) {
  print(getRandomExerciseCardImage());
}
