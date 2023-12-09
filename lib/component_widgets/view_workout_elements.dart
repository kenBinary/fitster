import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:fast_snackbar/fast_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/component_widgets/helper_functions.dart';
import 'package:fitster/services/db_operations.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class GroupIndicator extends StatelessWidget {
  const GroupIndicator({
    super.key,
    required this.groupName,
    required this.onAdd,
  });
  final String groupName;
  final Function onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFF9AB8F9),
        ),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                groupName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_box_outlined),
                iconSize: 30.0,
                onPressed: () {
                  onAdd();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCardImage extends StatefulWidget {
  const ExerciseCardImage({
    super.key,
    required this.groupName,
    required this.totalReps,
    required this.exerciseName,
  });
  final String groupName;
  final String exerciseName;
  final int totalReps;
  @override
  State<ExerciseCardImage> createState() => _ExerciseCardImageState();
}

class _ExerciseCardImageState extends State<ExerciseCardImage> {
  String currentGroup = '';
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    getCurrentMuscleGroup(docId: FirebaseAuth.instance.currentUser?.uid)
        .then((value) {
      setState(() {
        currentGroup = value;
      });
    });
    isExerciseFinished(
            docId: FirebaseAuth.instance.currentUser?.uid,
            exerciseName: widget.exerciseName)
        .then((value) {
      if (value) {
        setState(() {
          isDone = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groupName == currentGroup) {
      return GestureDetector(
        onTap: () {
          addCaloriesBurned(
            docId: FirebaseAuth.instance.currentUser?.uid,
            totalReps: widget.totalReps,
            exerciseName: widget.exerciseName,
          );
          if (isDone) {
            context.showFastSnackbar(
              'Exercise Unfinished',
              color: TypeFastSnackbar.error,
            );
          } else {
            context.showFastSnackbar(
              'Exercise Finished',
              color: TypeFastSnackbar.success,
            );
          }
          setState(() {
            isDone = !isDone;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: (isDone) ? Colors.green : Colors.redAccent,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Image.asset(
            getRandomExerciseCardImage(),
          ),
        ),
      );
    } else {
      return Image.asset(
        getRandomExerciseCardImage(),
      );
    }
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.exerciseName,
    required this.setNumber,
    required this.repNumber,
    required this.restTime,
    required this.onEdit,
    required this.onDelete,
    required this.index,
    required this.groupName,
  });
  final String exerciseName;
  final String setNumber;
  final String repNumber;
  final String restTime;
  final Function onEdit;
  final Function onDelete;
  final int index;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xfffbfbad),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        height: 105.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      exerciseName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$setNumber sets',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '$repNumber reps',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$restTime seconds rest',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ExerciseCardImage(
                  groupName: groupName,
                  totalReps: int.parse(repNumber) * int.parse(setNumber),
                  exerciseName: exerciseName,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        onEdit(
                          index,
                          exerciseName,
                          repNumber,
                          setNumber,
                          restTime,
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF9AB8F9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        height: 30,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('Edit'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {
                        onDelete(index);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF9AB8F9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        height: 30,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('Delete'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MuscleGroupSection extends StatelessWidget {
  MuscleGroupSection({super.key, required this.data});

  final Map<String, dynamic> data;
  final List<DialogTextField> newExerciseTextFields = [
    DialogTextField(
      hintText: 'exercise name',
      maxLength: 20,
      validator: (value) {
        RegExp isAlphaNumeric = RegExp(r'^[a-zA-Z\s]+$');
        if (value == null || value.isEmpty) {
          return 'empty';
        } else if (!isAlphaNumeric.hasMatch(value)) {
          return 'must be alphabetic';
        }
        return null;
      },
    ),
    DialogTextField(
      hintText: 'Number of reps',
      maxLength: 3,
      validator: (value) {
        RegExp isDigit = RegExp(r'^[0-9]+$');
        if (value == null || value.isEmpty) {
          return 'empty';
        } else if (!isDigit.hasMatch(value)) {
          return 'must be a digit';
        }
        return null;
      },
    ),
    DialogTextField(
      hintText: 'Number of sets',
      maxLength: 3,
      validator: (value) {
        RegExp isDigit = RegExp(r'^[0-9]+$');
        if (value == null || value.isEmpty) {
          return 'empty';
        } else if (!isDigit.hasMatch(value)) {
          return 'must be a digit';
        }
        return null;
      },
    ),
    DialogTextField(
      hintText: 'Time in Seconds',
      maxLength: 4,
      validator: (value) {
        RegExp isDigit = RegExp(r'^[0-9]+$');
        if (value == null || value.isEmpty) {
          return 'empty';
        } else if (!isDigit.hasMatch(value)) {
          return 'must be a digit';
        }
        return null;
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GroupIndicator(
          groupName: data['group'],
          onAdd: () async {
            showTextInputDialog(
              context: context,
              textFields: newExerciseTextFields,
              title: 'Exercise Details',
              okLabel: 'create',
            ).then((value) {
              if (value != null) {
                addNewExercise(
                  docId: FirebaseAuth.instance.currentUser?.uid,
                  targetGroup: data['group'],
                  exerciseName: value[0],
                  reps: value[1],
                  sets: value[2],
                  restTime: value[3],
                );
              }
            });
          },
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data['exercises'].length,
          itemBuilder: (context, index) {
            return ExerciseCard(
              groupName: data['group'],
              index: index,
              exerciseName: data['exercises'][index]['name'] as String,
              setNumber: data['exercises'][index]['sets'].toString(),
              repNumber: data['exercises'][index]['reps'].toString(),
              restTime: data['exercises'][index]['rest_time'].toString(),
              onEdit: (
                index,
                exerciseName,
                repNumber,
                setNumber,
                restTime,
              ) {
                showTextInputDialog(
                  context: context,
                  textFields: [
                    DialogTextField(
                      initialText: exerciseName,
                      maxLength: 20,
                      validator: (value) {
                        RegExp isAlphaNumeric = RegExp(r'^[a-zA-Z\s]+$');
                        if (value == null || value.isEmpty) {
                          return 'empty';
                        } else if (!isAlphaNumeric.hasMatch(value)) {
                          return 'must be alphabetic';
                        }
                        return null;
                      },
                    ),
                    DialogTextField(
                      initialText: repNumber,
                      maxLength: 3,
                      validator: (value) {
                        RegExp isDigit = RegExp(r'^[0-9]+$');
                        if (value == null || value.isEmpty) {
                          return 'empty';
                        } else if (!isDigit.hasMatch(value)) {
                          return 'must be a digit';
                        }
                        return null;
                      },
                    ),
                    DialogTextField(
                      initialText: setNumber,
                      maxLength: 3,
                      validator: (value) {
                        RegExp isDigit = RegExp(r'^[0-9]+$');
                        if (value == null || value.isEmpty) {
                          return 'empty';
                        } else if (!isDigit.hasMatch(value)) {
                          return 'must be a digit';
                        }
                        return null;
                      },
                    ),
                    DialogTextField(
                      initialText: restTime,
                      maxLength: 4,
                      validator: (value) {
                        RegExp isDigit = RegExp(r'^[0-9]+$');
                        if (value == null || value.isEmpty) {
                          return 'empty';
                        } else if (!isDigit.hasMatch(value)) {
                          return 'must be a digit';
                        }
                        return null;
                      },
                    ),
                  ],
                  title: 'Exercise Details',
                  okLabel: 'edit',
                ).then((value) {
                  if (value != null) {
                    editExercise(
                      docId: FirebaseAuth.instance.currentUser?.uid,
                      exerciseName: value[0],
                      reps: value[1],
                      sets: value[2],
                      restTime: value[3],
                      targetGroup: data['group'],
                      index: index,
                    );
                  }
                });
              },
              onDelete: (index) {
                showOkCancelAlertDialog(
                  context: context,
                  title: 'Delete Exercise',
                  message: 'Are You Sure you want to delete this exercise?',
                  okLabel: 'delete',
                ).then((value) {
                  if (value.index == 0) {
                    deleteExercise(
                      docId: FirebaseAuth.instance.currentUser?.uid,
                      targetGroup: data['group'],
                      index: index,
                    );
                  }
                });
              },
            );
          },
        )
      ],
    );
  }
}

class NoWorkoutPlan extends StatelessWidget {
  const NoWorkoutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Create a workout plan to view here',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(20),
        WidgetCircularAnimator(
          innerColor: HexColor('#0C4ACF'),
          outerColor: HexColor('#020A1D'),
          child: CircularProfileAvatar(
            '',
            borderColor: HexColor('#9AB8F9'),
            borderWidth: 3,
            elevation: 5,
            radius: 90,
            child: Image.asset(
              'assets/images/fitster-icon.png',
            ),
          ),
        ),
      ],
    );
  }
}
