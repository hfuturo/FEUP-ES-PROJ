import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:habit_hero/habbit.dart';

/// Notifications Page --------------------------------------------------------------------------------------------

class Notifications extends StatefulWidget {
  final List<Habit> habits;

  const Notifications({super.key, required this.habits});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Notification> notificationsList = [];

  void printPendingNotifications() async {
    List<NotificationModel> notifications =
        await AwesomeNotifications().listScheduledNotifications();

    List<Notification> updatedList = [];

    for (NotificationModel notification in notifications) {
      var scheduleMap = notification.schedule!.toMap();
      Color currentColor = Colors.red;

      for (Habit habit in widget.habits) {
        if (habit.name == notification.content!.title!) {
          currentColor = habit.color!;
        }
      }

      Notification newNotification = Notification(
        title: notification.content!.title!,
        color: currentColor,
        hour: scheduleMap["hour"],
        minute: scheduleMap["minute"],
        id: notification.content!.id!,
        onRemoved: () {
          setState(() {
            printPendingNotifications();
          });
        },
      );

      updatedList.add(newNotification);
    }

    setState(() {
      notificationsList = updatedList;
    });
  }

  @override
  void initState() {
    super.initState();
    printPendingNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return notificationsList[index];
              },
            ),
          ]),
        ));
  }
}

/// Notification Class ----------------------------------------------------------------------------------------------------------------

class Notification extends StatefulWidget {
  final String title;
  final Color color;
  final int id;
  final int hour;
  final int minute;
  final VoidCallback onRemoved;

  const Notification(
      {super.key,
      required this.title,
      required this.hour,
      required this.minute,
      required this.id,
      required this.onRemoved,
      required this.color});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  void _removeNotification() async {
    await AwesomeNotifications().cancel(widget.id);
    widget.onRemoved.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      width: double.infinity,
      height: 100,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 250,
            color: widget.color,
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              (widget.minute > 9)
                  ? "${widget.hour}:${widget.minute}"
                  : "${widget.hour}:0${widget.minute}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 5,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.highlight_remove_outlined),
              color: Colors.red,
              onPressed: () async {
                _removeNotification();
              },
            ),
          )
        ],
      ),
    );
  }
}
