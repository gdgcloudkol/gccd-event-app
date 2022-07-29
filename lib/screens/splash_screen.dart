import 'package:ccd2022app/entrypoint/navigation_screen.dart';
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
          height: 120,
          width: 120,
          fit: BoxFit.cover,
          image: const AssetImage("assets/images/splash.gif"),
          controller: _controller,
          autostart: Autostart.once,
          onFetchCompleted: () {
            Future.delayed(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NavigationScreen();
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
