import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/community_partners_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/referral_bloc.dart';
import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/blocs/sponsors.bloc.dart';
import 'package:ccd2022app/blocs/ticket_form_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/entrypoint/navigation_screen.dart';
import 'package:ccd2022app/screens/splash_screen.dart';
import 'package:ccd2022app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Initialising firebase app
  ///so that all firebase services can be used
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();

  ///Setting up fcm listener
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  enableEdgeToEdge();

  runApp(
    CCDApp(),
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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  CCDApp({Key? key}) : super(key: key);

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
          create: (context) => NavigationBloc(navigatorKey),
        ),
        ChangeNotifierProvider<TicketStatusBloc>(
          create: (context) => TicketStatusBloc(),
        ),
        ChangeNotifierProvider<SpeakersBloc>(
          create: (context) => SpeakersBloc(),
        ),
        ChangeNotifierProvider<SponsorsBloc>(
          create: (context) => SponsorsBloc(),
        ),
        ChangeNotifierProvider<CommunityPartnersBloc>(
          create: (context) => CommunityPartnersBloc(),
        ),
        ChangeNotifierProvider<ReferralBloc>(
          create: (context) => ReferralBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'CCD 2022',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: navigatorKey,
        home: kDebugMode ? const NavigationScreen() : const SplashScreen(),
      ),
    );
  }
}
