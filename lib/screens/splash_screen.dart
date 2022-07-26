import 'package:ccd2022app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  GifController? _controller;

  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Gif(
          image: const AssetImage("assets/images/splash.gif"),
          controller: _controller,
          // if duration and fps is null, original gif fps will be used.
          autostart: Autostart.once,
          onFetchCompleted: () {
            Future.delayed(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
