import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/model_theme.dart';
import 'package:habit_hero/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:habit_hero/mytheme_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopState();
}

class _ShopState extends State<ShopPage> {
  Future<void> getThemeValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      selectedColorTheme =
          sharedPreferences.getInt(MyThemePreferences.THEME_KEY) ?? 0;
    });
  }

  @override
  void initState() {
    points = 0;
    getUser(user.email!);
    getThemeValue();
    super.initState();
  }

  void getUser(String email) async {
    final snapshot =
        await db.collection("Users").where("mail", isEqualTo: email).get();

    userModelList = snapshot.docs.map((e) => UserModel.fromJson(e)).toList();

    for (UserModel currentUser in userModelList) {
      setState(() {
        points = currentUser.points;
        debugPrint(points.toString());
        unlockedOptions = currentUser.unlockedColors;
      });
    }
  }

  void spendPoints(String email) async {
    final docUser =
        FirebaseFirestore.instance.collection("Users").doc(user.uid);

    docUser.update({
      "points": points,
      "unlockedColors": unlockedOptions,
    });
  }

  final db = FirebaseFirestore.instance;
  late List<UserModel> userModelList;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.brown,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.grey,
  ];

  List<Map<String, dynamic>> unlockedOptions = [
    {'color': Colors.red.value, 'unlocked': false},
    {'color': Colors.green.value, 'unlocked': false},
    {'color': Colors.blue.value, 'unlocked': false},
    {'color': Colors.yellow.value, 'unlocked': false},
    {'color': Colors.orange.value, 'unlocked': true},
    {'color': Colors.purple.value, 'unlocked': false},
    {'color': Colors.pink.value, 'unlocked': false},
    {'color': Colors.teal.value, 'unlocked': false},
    {'color': Colors.amber.value, 'unlocked': false},
    {'color': Colors.indigo.value, 'unlocked': false},
    {'color': Colors.brown.value, 'unlocked': false},
    {'color': Colors.deepOrange.value, 'unlocked': false},
    {'color': Colors.lightGreen.value, 'unlocked': false},
    {'color': Colors.grey.value, 'unlocked': false},
  ];

  int selectedColorTheme = Colors.orange.value;
  late int points; // Total points earned

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Shop                          $points Points'),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 60,
                        width: 180,
                        child: const Text(
                          "Theme",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20,
                  ),
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 40.0,
                    mainAxisSpacing: 40.0,
                    children: colors.asMap().entries.map((entry) {
                      int index = entry.key;
                      Color color = entry.value;
                      bool isUnlocked = unlockedOptions[index]["unlocked"];
                      bool isSelected = color.value == selectedColorTheme;

                      return GestureDetector(
                        onTap: () {
                          if (isUnlocked) {
                            setState(() {
                              selectedColorTheme = color.value;
                              themeNotifier.color = selectedColorTheme;
                            });
                          } else {
                            // Option locked, perform unlock logic
                            if (points >= 10) {
                              setState(() {
                                unlockedOptions[index]["unlocked"] = true;
                                selectedColorTheme = color.value;
                                themeNotifier.color = selectedColorTheme;
                                points -= 10; // Deduct 10 points for unlocking
                                spendPoints(user.email!);
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Insufficient Points'),
                                    content: const Text(
                                        'You do not have enough points to unlock this option.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          child: isUnlocked
                              ? null
                              : const Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: "10"),
                                        WidgetSpan(
                                            child: Icon(
                                          Icons.star_outlined,
                                          size: 18,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
