import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SlidingCard extends StatelessWidget {
  final String name;
  final String sub;
  final String logo;
  final String url;

  const SlidingCard({
    Key? key,
    required this.name,
    required this.sub,
    required this.offset,
    required this.logo,
    required this.url,
  }) : super(key: key);

  final double offset;

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 300,
        ),
        Positioned(
          top: 50,
          child: Card(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Transform.translate(
              offset: Offset(-32 * gauss * offset.sign, 0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/ccd_background.png"),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    CardContent(
                      name: name,
                      sub: sub,
                      url: url,
                      offset: gauss,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: Transform.translate(
            offset: Offset(15 * offset, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Image.asset(
                    logo,
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String sub;
  final String url;
  final double offset;

  const CardContent(
      {Key? key,
      required this.name,
      required this.sub,
      required this.url,
      required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Transform.translate(
            offset: Offset(4 * offset, 0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(15 * offset, 0),
            child: Text(
              sub,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Transform.translate(
            offset: Offset(15 * offset, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff55acee),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () {
                launchUrlString(
                  url,
                  mode: LaunchMode.externalApplication,
                );
              },
              child: const SizedBox(
                height: 50,
                width: 140,
                child: Center(
                  child: Text(
                    'Visit',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
