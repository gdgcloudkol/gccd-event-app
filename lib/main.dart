import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/screens/login_screen.dart';
import 'package:ccd2022app/screens/registration_screen.dart';
import 'package:ccd2022app/screens/welcome_screen.dart';
import 'package:ccd2022app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Initialising firebase app
  ///so that all firebase services can be used
  ///TODO uncomment this once firebase project is available
  // if (Firebase.apps.isEmpty) await Firebase.initializeApp();

  runApp(
    const CCDApp(),
  );
}

class CCDApp extends StatelessWidget {
  const CCDApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'CCD 2022',
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        theme: lightTheme,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
        },
      ),
    );
  }
}
