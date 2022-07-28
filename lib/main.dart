import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/ticket_form_bloc.dart';
import 'package:ccd2022app/entrypoint/navigation_screen.dart';
import 'package:ccd2022app/screens/splash_screen.dart';
import 'package:ccd2022app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ///Loading environment Variables
  // await dotenv.load(fileName: ".env");

  ///Initialising firebase app
  ///so that all firebase services can be used
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();

  enableEdgeToEdge();

  runApp(
    const CCDApp(),
  );
}

void enableEdgeToEdge({bool enable = true}) {
  ///Necessary for edge to edge
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
        ChangeNotifierProvider<TicketFormBloc>(
          create: (context) => TicketFormBloc(),
        ),
        ChangeNotifierProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'CCD 2022',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
