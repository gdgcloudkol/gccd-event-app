import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/screens/dashboard/dashboard_screen.dart';
import 'package:ccd2022app/screens/home/home_screen.dart';
import 'package:ccd2022app/screens/referral/refer_and_earn_screen.dart';
import 'package:ccd2022app/screens/speakers_screen.dart';
import 'package:ccd2022app/screens/sponsors/partners_screen.dart';
import 'package:ccd2022app/services/fcm.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/widgets/drawer.dart';
import 'package:ccd2022app/widgets/foreground_notification_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);
  static const String routeName = 'navigation_screen';

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NavigationBloc nb = Provider.of<NavigationBloc>(context, listen: false);
      Fcm fcm = Fcm(nb: nb);
      fcm.setupInteractedMessage();
      setupLocalNotificationsAndForegroundMessageListener(nb);
    });
    super.initState();
  }

  Future setupLocalNotificationsAndForegroundMessageListener(
    NavigationBloc nb,
  ) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    setForegroundMessageListener(
      flutterLocalNotificationsPlugin,
      channel,
      nb.navigatorKey.currentState?.context,
      nb,
    );
  }

  @override
  Widget build(BuildContext context) {
    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    AuthBloc ab = Provider.of<AuthBloc>(context);

    return WillPopScope(
      ///Custom navigation to transform single page behaviour into multi page stacked nav
      onWillPop: () {
        if (nb.navStack.isEmpty || nb.navStack.length == 1) {
          return Future.value(true);
        } else {
          nb.removeTopIndexFromNavStack();
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: getBody(nb.navIndex),
        drawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 5,
          centerTitle: ab.isLoggedIn && !(ab.profilePicUrl == ""),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            nb.screenNames[nb.navIndex] ?? "",
            style: const TextStyle(
              fontFamily: "GoogleSans",
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            if (ab.isLoggedIn && !(ab.profilePicUrl == ""))
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  _showPopupMenu(details.globalPosition, nb);
                },
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    ab.profilePicUrl,
                  ),
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
              ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 3:
        return const SpeakersScreen();
      case 4:
        return const PartnersScreen();
      case 7:
        return const DashboardScreen();
      case 11:
        return const ReferAndEarn();
      default:
        return const HomeScreen();
    }
  }

  Future<void> setForegroundMessageListener(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    AndroidNotificationChannel channel,
    BuildContext? context,
    NavigationBloc nb,
  ) async {
    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        if (context != null) {
          showDialog(
              context: context,
              builder: (context) {
                return ForegroundNotificationDialog(
                  title: notification.title ?? "",
                  body: notification.body ?? "",
                  nb: nb,
                  screen: message.data[Config.fcmArgScreen] ?? "",
                );
              });
        }
      }
    });
  }

  _showPopupMenu(Offset offset, NavigationBloc nb) async {
    double left = offset.dx;
    double top = offset.dy;
    String? selection = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top + 35, 25, 0),
      items: [
        PopupMenuItem<String>(
          value: '1',
          child: getSinglePopupItem('Profile', FontAwesomeIcons.user),
        ),
        PopupMenuItem<String>(
          value: '7',
          child: getSinglePopupItem('Dashboard', Icons.dashboard_outlined),
        ),
      ],
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    if (selection != null) {
      nb.changeNavIndex(int.tryParse(selection) ?? 0);
    }
  }

  Widget getSinglePopupItem(
    String itemName,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 25,
        ),
        Text(
          itemName,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "GoogleSans",
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
