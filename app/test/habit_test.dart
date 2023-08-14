import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:habit_hero/habbit.dart';

void main() {
  late Habit habit;
  late Color color;
  late String name;
  late int progress;
  late String id;
  late bool completed;
  late DateTime lastCompleted;
  late int streak;
  late Function(Habit) onDelete;
  late Function() onComplete;
  late String email;
  late HabitModel habitModel;

  setUp(() {
    void doNothing(Habit habit) {}
    void doNothing2() {}
    onComplete = doNothing2;
    onDelete = doNothing;
    color = Colors.black;
    name = 'teste';
    progress = 40;
    id = '2';
    completed = false;
    lastCompleted = DateTime.now();
    streak = 2;
    email = 'teste@gmail.com';
    habit = Habit(
        color: color,
        name: name,
        progress: progress,
        id: id,
        onDelete: onDelete,
        completed: completed,
        lastCompleted: lastCompleted,
        onComplete: onComplete,
        streak: streak);

    habitModel = HabitModel(
        name: name,
        email: email,
        color: streak,
        progress: progress,
        id: id,
        completed: completed,
        lastCompleted: lastCompleted,
        streak: streak);
  });

  group('Habit Unit Tests', () {
    test('Default Constructor (color should be red)', () {
      Habit habitDefault = Habit(
          name: name,
          progress: progress,
          id: id,
          onDelete: onDelete,
          completed: completed,
          lastCompleted: lastCompleted,
          onComplete: onComplete,
          streak: streak);
      expect(habitDefault.color, Colors.red);
      expect(habitDefault.name, name);
      expect(habitDefault.progress, progress);
      expect(habitDefault.id, id);
      expect(habitDefault.onDelete, onDelete);
      expect(habitDefault.completed, completed);
      expect(habitDefault.lastCompleted, lastCompleted);
      expect(habitDefault.onComplete, onComplete);
      expect(habitDefault.streak, streak);
    });

    test('Constructor with color initialization', () {
      expect(habit.color, color);
      expect(habit.name, name);
      expect(habit.progress, progress);
      expect(habit.id, id);
      expect(habit.onDelete, onDelete);
      expect(habit.completed, completed);
      expect(habit.lastCompleted, lastCompleted);
      expect(habit.onComplete, onComplete);
      expect(habit.streak, streak);
    });
  });

  group('HabitModel tests', () {
    testWidgets('habit model constructor', (WidgetTester tester) async {
      expect(habitModel.name, name);
      expect(habitModel.email, email);
      expect(habitModel.color, streak);
      expect(habitModel.progress, progress);
      expect(habitModel.id, id);
      expect(habitModel.completed, completed);
      expect(habitModel.lastCompleted, lastCompleted);
      expect(habitModel.streak, streak);
    });
  });
}
