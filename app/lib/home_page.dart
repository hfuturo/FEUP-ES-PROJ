import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/add_habit.dart';
import 'package:habit_hero/habbit.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:habit_hero/shop.dart';
import 'package:habit_hero/signup_page.dart';
import 'auth_page.dart';
import 'notifications.dart';

enum MenuValues {
  notifications,
  shop,
  signout,
}

List<Habit> habits = [];

late int points;

var user = FirebaseAuth.instance.currentUser!;

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    points = 0;
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) => {
            if (!isAllowed)
              {AwesomeNotifications().requestPermissionToSendNotifications()}
          },
        );
    user = FirebaseAuth.instance.currentUser!;
    getUser(user.email!);
    getHabits(user.email!);
    super.initState();
  }

  int currentpage = 0;
  final db = FirebaseFirestore.instance;
  late List<HabitModel> habitModelList;
  late List<UserModel> userModelList;

  void _removeHabit(Habit habit) {
    setState(() {
      habits.remove(habit);
    });
  }

  void _updatePoints() {
    setState(() {
      getUser(user.email!);
    });
  }

  void getUser(String email) async {
    final snapshot =
        await db.collection("Users").where("mail", isEqualTo: email).get();

    userModelList = snapshot.docs.map((e) => UserModel.fromJson(e)).toList();

    for (UserModel currentUser in userModelList) {
      setState(() {
        points = currentUser.points;
      });
    }
  }

  void getHabits(String email) async {
    final snapshot =
        await db.collection("Habits").where("mail", isEqualTo: email).get();

    habitModelList = snapshot.docs.map((e) => HabitModel.fromJson(e)).toList();
    debugPrint(user.email!);
    setState(() {
      habits.clear();
    });

    for (HabitModel habit in habitModelList) {
      final docHabit =
          FirebaseFirestore.instance.collection("Habits").doc(habit.id);

      setState(() {
        if (habit.completed == true) {
          bool isDayAfterGivenDate =
              DateTime.now().difference(habit.lastCompleted).inDays >= 1;

          bool isMoreThanDayAfterGivenDate =
              DateTime.now().difference(habit.lastCompleted).inDays >= 2;

          if (isDayAfterGivenDate) {
            habit.completed = false;

            docHabit.update({
              "completed": habit.completed,
            });
          }

          if (isMoreThanDayAfterGivenDate) {
            habit.streak = 0;
            habit.progress = 0;

            docHabit.update({
              "streak": habit.streak,
              "progress": habit.progress,
            });
          }
        }

        Habit newHabit = Habit(
          id: habit.id,
          name: habit.name,
          color: Color(habit.color),
          progress: habit.progress,
          onDelete: _removeHabit,
          onComplete: _updatePoints,
          completed: habit.completed,
          lastCompleted: habit.lastCompleted,
          streak: habit.streak,
        );

        habits.add(newHabit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: points.toString()),
              const WidgetSpan(child: Icon(Icons.star_outlined)),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: habits.length,
              itemBuilder: (BuildContext context, int index) {
                return habits[index];
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              height: 55,
              child: IconButton(
                padding: EdgeInsets.zero,
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return AddHabit(
                        listLength: habits.length,
                        onDelete: _removeHabit,
                        onComplete: _updatePoints,
                      );
                    }),
                  ).then((newHabit) {
                    if (newHabit != null) {
                      setState(() {
                        getHabits(user.email!);
                      });
                    }
                  });
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///AwesomeNotifications().cancelAllSchedules();
        },
        child: Theme(
          data: Theme.of(context).copyWith(
            cardColor: Theme.of(context).primaryColor,
          ),
          child: PopupMenuButton(
            splashRadius: 30,
            tooltip: "",
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(
                value: MenuValues.notifications,
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              PopupMenuItem(
                value: MenuValues.shop,
                child: Text(
                  "Shop",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              PopupMenuItem(
                value: MenuValues.signout,
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              switch (value) {
                case MenuValues.notifications:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Notifications(
                          habits: habits,
                        );
                      },
                    ),
                  );
                  break;
                case MenuValues.signout:
                  FirebaseAuth.instance.signOut();

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const AuthPage();
                    }),
                  );

                  break;
                case MenuValues.shop:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const ShopPage();
                    }),
                  ).then((value) => setState(() {
                        getUser(user.email!);
                      }));
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
