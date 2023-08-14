import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_hero/notifications.dart' as not;

void main() {
  late not.Notifications notifications;
  late not.Notification notification;
  late String title;
  late Color color;
  late int id;
  late int hour;
  late int minute;
  late VoidCallback onRemoved;

  setUp(() {
    void doNothing() {}
    title = 'title';
    color = Colors.black;
    id = 1;
    hour = 14;
    minute = 20;
    onRemoved = doNothing;
    notification = not.Notification(
        title: title,
        color: color,
        id: id,
        hour: hour,
        minute: minute,
        onRemoved: onRemoved);
    notifications = const not.Notifications(habits: []);
  });

  group('Notification tests', () {
    testWidgets('Constructor', (WidgetTester tester) async {
      expect(notification.title, title);
      expect(notification.color, color);
      expect(notification.id, id);
      expect(notification.hour, hour);
      expect(notification.minute, minute);
      expect(notification.onRemoved, onRemoved);
    });
  });

  group('Notifications tests', () {
    testWidgets('Notifications constructor', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: notifications));
      expect(notifications.habits, []);
    });
  });
}
