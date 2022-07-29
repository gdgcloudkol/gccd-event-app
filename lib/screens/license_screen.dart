import 'package:flutter/material.dart';

class AppLicense extends StatelessWidget {
  const AppLicense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: "GoogleSans",
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        textTheme: const TextTheme(
          headline5: TextStyle(color: Colors.black, fontFamily: "GoogleSans"),
          caption: TextStyle(color: Colors.black, fontFamily: "GoogleSans"),
          bodyText2: TextStyle(
            color: Colors.black,
            fontFamily: "GoogleSans",
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: LicensePage(
        applicationIcon: Image.asset(
          "assets/images/Logo.png",
          width: 100,
          height: 100,
        ),
        applicationName: "CCD 2022",
        applicationVersion: "v0.0.1",
        applicationLegalese: "© GDG Cloud Kolkata",
      ),
    );
  }
}
