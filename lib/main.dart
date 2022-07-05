import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/screens/login_screen.dart';
import 'package:ccd2022app/screens/registration_screen.dart';
import 'package:ccd2022app/screens/welcome_screen.dart';
import 'package:ccd2022app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Loading environment Variables
  await dotenv.load(fileName: ".env");

  ///Initialising firebase app
  ///so that all firebase services can be used
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();

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
        ///Root Level Provider for Authentication logics
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
