import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async';

import 'home_page.dart';

// ignore: must_be_immutable
class Habit extends StatefulWidget {
  Color? color;
  String name;
  int progress;
  String id;
  bool completed = false;
  DateTime lastCompleted;
  int streak;
  Function(Habit) onDelete;
  Function() onComplete;

  Habit({
    super.key,
    this.color = Colors.red,
    required this.name,
    required this.progress,
    required this.id,
    required this.onDelete,
    required this.completed,
    required this.lastCompleted,
    required this.onComplete,
    required this.streak,
  });

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  final textController = TextEditingController();

  bool showCheckIcon = false;
  double barWidth = 150;
  bool edit = false;
  bool notification = false;
  int frequency = 0;
  List<String> frequencyOptions = [
    "Once A Day",
    "Once A Week",
    "Once A Month",
  ];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    textController.text = widget.name;
  }

  void updateColor(Color newColor) {
    setState(() {
      widget.color = newColor;

      final docUser =
          FirebaseFirestore.instance.collection("Habits").doc(widget.id);

      docUser.update({
        "color": newColor.value,
      });
    });
  }

  void updateStreak(int newStreak) {
    setState(() {
      widget.streak = newStreak;

      final docUser =
          FirebaseFirestore.instance.collection("Habits").doc(widget.id);

      docUser.update({
        "streak": newStreak,
      });
    });
  }

  void updatePoints(int newPoints) {
    setState(() {
      points = newPoints;

      final docUser =
          FirebaseFirestore.instance.collection("Users").doc(user.uid);

      docUser.update({
        "points": newPoints,
      });
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  triggerNotification() async {
    int year = selectedDate.year;
    int month = selectedDate.month;
    int day = selectedDate.day;
    int weekday = selectedDate.weekday;
    int hour = selectedTime.hour;
    int minute = selectedTime.minute;
    DateTime notificationTime = DateTime(year, month, day, hour, minute);

    // If the notification time has already passed today, schedule it for tomorrow
    if (notificationTime.isBefore(DateTime.now())) {
      notificationTime = notificationTime.add(const Duration(days: 1));
    }

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: UniqueKey().hashCode,
          channelKey: 'call_channel',
          title: widget.name,
          body: "Time To Complete Your Habits For The Day",
          wakeUpScreen: true,
          category: NotificationCategory.Reminder,
        ),
        schedule: NotificationCalendar(
          weekday: (frequency == 1) ? weekday : null,
          day: (frequency == 2) ? day : null,
          hour: notificationTime.hour,
          minute: notificationTime.minute,
          second: 0,
          repeats: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(30),
      ),
      height: (edit | notification) ? 370 : 100,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Stack(
        children: [
          Visibility(
            visible: edit,
            child: Positioned(
              top: 15,
              left: 20,
              child: SizedBox(
                height: 50,
                width: 160,
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText:
                        textController.text.isEmpty ? textController.text : "",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !edit && !widget.completed,
            child: Positioned(
              top: 50,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.streak++;

                    points += streakToPoints(widget.streak);
                    int progressAdd = streakToAdd(widget.streak);

                    updatePoints(points);
                    updateStreak(widget.streak);
                    widget.onComplete();

                    widget.completed = true;
                    widget.progress = widget.progress + progressAdd;
                    widget.lastCompleted = DateTime.now();
                    showCheckIcon = true;

                    final docUser = FirebaseFirestore.instance
                        .collection("Habits")
                        .doc(widget.id);

                    docUser.update({
                      "completed": widget.completed,
                      "progress": widget.progress,
                      "lastCompleted": widget.lastCompleted,
                    });

                    Timer(const Duration(seconds: 3), () {
                      setState(() {
                        showCheckIcon = false;
                      });
                    });
                  });
                },
                child: const Icon(
                  Icons.circle_outlined,
                  size: 40,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: showCheckIcon ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 40,
                ),
              ),
            ),
          ),
          Visibility(
            visible: !edit,
            child: Positioned(
              top: 15,
              left: 20,
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 15,
            child: IconButton(
              hoverColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  textController.text = widget.name;
                  edit = !edit;
                  notification = false;
                });
              },
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
            ),
          ),
          const Positioned(
            top: 67,
            right: 25,
            child: Icon(
              Icons.fireplace,
              size: 20,
            ),
          ),
          Positioned(
            top: 72,
            right: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 10,
              width: barWidth,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 10,
                width: barWidth * ((widget.progress % 100) / 100),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 130,
            child: Text(
              widget.streak.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Visibility(
            visible: edit,
            child: Positioned(
              left: 20,
              top: 150,
              child: Row(
                children: [
                  const Text(
                    "Share",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 35,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mail,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "Goals",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Container(
                    height: 35,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sentiment_satisfied_outlined,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: edit,
            child: Positioned(
              left: 20,
              top: 205,
              child: Row(
                children: [
                  const Text(
                    "Color",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Container(
                    height: 35,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        iconSize: 0,
                        value: Color(widget.color!.value),
                        items: <Color>[
                          Color(Colors.green.value),
                          Color(Colors.blue.value),
                          Color(Colors.red.value),
                          Color(Colors.orange.value),
                          Color(Colors.purple.value),
                          Color(Colors.yellow.value),
                        ].map<DropdownMenuItem<Color>>((Color color) {
                          return DropdownMenuItem<Color>(
                            alignment: Alignment.center,
                            value: color,
                            child: Container(
                              height: 15,
                              width: 15,
                              color: color,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          updateColor(value!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "Insights",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 35,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_graph_outlined,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: edit,
            child: Positioned(
              top: 255,
              left: 75,
              child: Row(
                children: [
                  const Text(
                    "Notification",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 35,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications),
                      iconSize: 20,
                      onPressed: () {
                        setState(() {
                          edit = false;
                          notification = true;
                          selectedDate = DateTime.now();
                          selectedTime = TimeOfDay.now();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: edit,
            child: Positioned(
              top: 250,
              right: -20,
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.name = textController.text;

                      final docUser = FirebaseFirestore.instance
                          .collection("Habits")
                          .doc(widget.id);

                      docUser.update({
                        "name": widget.name,
                      });

                      edit = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8)),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: edit,
            child: Positioned(
              top: 300,
              right: -20,
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final docUser = FirebaseFirestore.instance
                          .collection("Habits")
                          .doc(widget.id);

                      docUser.delete();
                    });
                    edit = false;
                    widget.onDelete(widget);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(8)),
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: notification,
            child: Positioned(
              top: 150,
              left: 25,
              child: Row(
                children: const [
                  Text(
                    "Starting Date",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    "Frequency",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: notification,
            child: Positioned(
              top: 185,
              left: 20,
              child: SizedBox(
                height: 55,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade400,
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(selectedDate),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: notification,
            child: Positioned(
              top: 185,
              left: 170,
              child: SizedBox(
                height: 55,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<int>(
                    dropdownColor: Colors.grey.shade400,
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    value: frequency,
                    onChanged: (value) {
                      setState(() {
                        frequency = value!;
                      });
                    },
                    items: <int>[
                      0,
                      1,
                      2,
                    ].map<DropdownMenuItem<int>>((int option) {
                      return DropdownMenuItem<int>(
                        value: option,
                        child: SizedBox(
                          child: Text(
                            frequencyOptions[option],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: notification,
            child: const Positioned(
              top: 255,
              left: 25,
              child: Text(
                "Starting Date",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Visibility(
            visible: notification,
            child: Positioned(
              top: 285,
              left: 20,
              child: SizedBox(
                height: 55,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    selectTime(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade400,
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    selectedTime.format(context),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: notification,
              child: Positioned(
                top: 290,
                left: 170,
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        notification = false;
                        triggerNotification();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(20)),
                    child: const Text(
                      "Set Reminder",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class HabitModel {
  final String name;
  final String email;
  final int color;
  int progress;
  final String id;
  bool completed;
  final DateTime lastCompleted;
  int streak;

  HabitModel({
    required this.name,
    required this.email,
    required this.color,
    required this.progress,
    required this.id,
    required this.completed,
    required this.lastCompleted,
    required this.streak,
  });

  factory HabitModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return HabitModel(
      id: data["id"],
      name: data["name"],
      email: data["mail"],
      color: data["color"],
      progress: data["progress"],
      completed: data["completed"],
      lastCompleted: (data["lastCompleted"] as Timestamp).toDate(),
      streak: data["streak"],
    );
  }
}

int streakToPoints(int streak) {
  switch (streak) {
    case 2:
      return 1;
    case 12:
      return 10;
    case 33:
      return 50;
    default:
      return 0;
  }
}

int streakToAdd(int streak) {
  if (streak <= 2) {
    return 50;
  } else if (streak <= 12) {
    return 10;
  } else if (streak <= 33) {
    return 5;
  }

  return 0;
}
