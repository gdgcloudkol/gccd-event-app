import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("CCD 2022",style: TextStyle(fontFamily: "GoogleSans",fontSize: 25,fontWeight: FontWeight.w700),),
      ),
    );
  }
}
