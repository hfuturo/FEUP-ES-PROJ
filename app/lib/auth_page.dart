import 'package:flutter/material.dart';
import 'package:habit_hero/login_page.dart';

import 'signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginPage(onClickedSignIn: toggle)
        : SignUpPage(onClickedSignUp: toggle);
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
