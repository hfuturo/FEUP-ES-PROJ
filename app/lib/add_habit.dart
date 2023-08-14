import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/habbit.dart';

class AddHabit extends StatefulWidget {
  final int listLength;
  final Function(Habit) onDelete;
  final Function() onComplete;

  const AddHabit({
    super.key,
    required this.listLength,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final textController = TextEditingController();

  late Habit newHabit;
  late String id;

  String habitName = '';
  Color habitColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Habit'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<Color>(
                    decoration: const InputDecoration(
                      labelText: "Color",
                      border: OutlineInputBorder(),
                    ),
                    value: habitColor,
                    onChanged: (value) {
                      setState(() {
                        habitColor = value!;
                      });
                    },
                    items: <Color>[
                      Colors.green,
                      Colors.blue,
                      Colors.red,
                      Colors.orange,
                      Colors.purple,
                      Colors.yellow,
                    ].map<DropdownMenuItem<Color>>((Color color) {
                      return DropdownMenuItem<Color>(
                        value: color,
                        child: Container(
                          height: 20,
                          width: 20,
                          color: color,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    habitName = textController.text;

                    writeDataToFirebase(
                      mail: user.email!,
                      name: habitName,
                      color: habitColor.value,
                      progress: 0,
                      completed: false,
                      lastCompleted: DateTime(2000, 1, 1),
                      streak: 0,
                    );

                    newHabit = Habit(
                      id: id,
                      key: UniqueKey(),
                      name: habitName,
                      color: habitColor,
                      progress: 0,
                      onDelete: widget.onDelete,
                      onComplete: widget.onComplete,
                      completed: false,
                      lastCompleted: DateTime(2000, 1, 1),
                      streak: 0,
                    );
                  });

                  Navigator.pop(context, newHabit);
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.all(20)),
                child: const Text(
                  "Add Habit",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future writeDataToFirebase({
    required String mail,
    required String name,
    required int color,
    required int progress,
    required bool completed,
    required DateTime lastCompleted,
    required int streak,
  }) async {
    final docHabit = FirebaseFirestore.instance.collection('Habits').doc();

    id = docHabit.id;

    final json = {
      'id': id,
      'mail': mail,
      'name': name,
      'color': color,
      'progress': progress,
      'completed': completed,
      'lastCompleted': lastCompleted,
      'streak': streak,
    };

    await docHabit.set(json);
  }
}
