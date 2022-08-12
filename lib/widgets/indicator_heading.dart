import 'package:flutter/material.dart';

class IndicatorHeading extends StatelessWidget {
  const IndicatorHeading({Key? key, required this.title, required this.indicatorColor}) : super(key: key);

  final String title;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: indicatorColor,
            ),
            width: 10,
            height: 70,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }
}
