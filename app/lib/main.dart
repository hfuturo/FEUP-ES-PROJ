import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:habit_hero/model_theme.dart';
import 'package:habit_hero/utils.dart';
import 'package:provider/provider.dart';
import 'auth_page.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'call_channel',
          channelName: "Basic Notifications",
          channelDescription: "Basic Description"),
    ],
    debug: true,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          navigatorKey: navigatorKey,
          home: const MainPage(),
          debugShowCheckedModeBanner: false,
          theme: getThemeData(themeNotifier.color),
        );
      }),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went Wrong"),
            );
          } else if (snapshot.hasData) {
            return const RootPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}

ThemeData getThemeData(int theme) {
  if (theme == Colors.red.value) {
    return ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Colors.red[100],
    );
  }

  if (theme == Colors.green.value) {
    return ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.green[100],
    );
  }

  if (theme == Colors.blue.value) {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.blue[100],
    );
  }

  if (theme == Colors.yellow.value) {
    return ThemeData(
      primarySwatch: Colors.yellow,
      scaffoldBackgroundColor: Colors.yellow[100],
    );
  }

  if (theme == Colors.orange.value) {
    return ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.orange[100],
    );
  }

  if (theme == Colors.purple.value) {
    return ThemeData(
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: Colors.purple[100],
    );
  }

  if (theme == Colors.pink.value) {
    return ThemeData(
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Colors.pink[100],
    );
  }

  if (theme == Colors.teal.value) {
    return ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.teal[100],
    );
  }

  if (theme == Colors.amber.value) {
    return ThemeData(
      primarySwatch: Colors.amber,
      scaffoldBackgroundColor: Colors.amber[100],
    );
  }

  if (theme == Colors.indigo.value) {
    return ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.indigo[100],
    );
  }

  if (theme == Colors.brown.value) {
    return ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: Colors.brown[100],
    );
  }

  if (theme == Colors.deepOrange.value) {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.deepOrange[100],
    );
  }

  if (theme == Colors.lightGreen.value) {
    return ThemeData(
      primarySwatch: Colors.lightGreen,
      scaffoldBackgroundColor: Colors.lightGreen[100],
    );
  }

  if (theme == Colors.grey.value) {
    return ThemeData(
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Colors.grey[100],
    );
  }

  return ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.orange[100],
  );
}
