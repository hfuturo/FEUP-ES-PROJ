import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:habit_hero/add_habit.dart';
import 'package:habit_hero/habbit.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late AddHabit addHabit;
  late Function(Habit) onDelete;
  late Function() onComplete;
  late int listLength;

  setUp(() {
    void doNothing(Habit habit) {}
    void doNothing2() {}
    onDelete = doNothing;
    onComplete = doNothing2;
    listLength = 0;
    addHabit = AddHabit(
        listLength: listLength, onDelete: onDelete, onComplete: onComplete);
  });

  //tests the public methods of the classes and see if they are working properly
  group('Add_Habit Unit Tests', () {
    test('Default constructor', () {
      expect(addHabit.listLength, listLength);
      expect(addHabit.onComplete, onComplete);
      expect(addHabit.onDelete, onDelete);
    });
  });
}
