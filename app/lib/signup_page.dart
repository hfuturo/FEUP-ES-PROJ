import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/utils.dart';

import 'home_page.dart';
import 'main.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickedSignUp;

  const SignUpPage({
    super.key,
    required this.onClickedSignUp,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Image.asset('images/hh_logo.png'),
              ),
              const SizedBox(
                height: 60,
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    height: 500,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: 250,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 2, 0, 2),
                              child: TextFormField(
                                key: const Key('email_form'),
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w900),
                                  icon: Icon(Icons.email),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? "Enter A Valid Email"
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 250,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 2, 0, 2),
                                child: TextFormField(
                                  key: const Key('password_form'),
                                  controller: _passwordController,
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.w900),
                                    icon: Icon(Icons.lock),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (password) =>
                                      password != null && password.length < 6
                                          ? "Enter Min. 6 Characters"
                                          : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            key: const Key('SignUpButton'),
                            onPressed: () {
                              signUp();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.blue.shade300,
                                padding: const EdgeInsets.all(5)),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        RichText(
                          key: const Key('login'),
                          text: TextSpan(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              text: "Already Have An Account?  ",
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: "Log In",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    user = FirebaseAuth.instance.currentUser!;

    writeDataToFirebase(mail: _emailController.text.trim(), points: 0);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

Future writeDataToFirebase({
  required String mail,
  required int points,
}) async {
  String id = user.uid;

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

  final docHabit = FirebaseFirestore.instance.collection('Users').doc(id);

  final json = {
    'id': id,
    'mail': mail,
    'points': points,
    'unlockedColors': unlockedOptions,
  };

  await docHabit.set(json);
}

class UserModel {
  final String id;
  final String email;
  final int points;
  final List<Map<String, dynamic>> unlockedColors;

  UserModel({
    required this.id,
    required this.email,
    required this.points,
    required this.unlockedColors,
  });

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
        id: data["id"],
        email: data["mail"],
        points: data["points"],
        unlockedColors:
            List<Map<String, dynamic>>.from(data["unlockedColors"]));
  }
}
