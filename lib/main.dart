import 'package:ccd2022app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:ccd2022app/screens/login_screen.dart';
import 'package:ccd2022app/screens/registration_screen.dart';
import 'package:ccd2022app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCD 2022',
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      theme: lightTheme,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
      },
    );
  }
}
