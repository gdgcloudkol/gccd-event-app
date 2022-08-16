import 'package:flutter/material.dart';

class TechnologyChip extends StatelessWidget {
  const TechnologyChip({Key? key, required this.technology}) : super(key: key);

  final String technology;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(80),
      ),
      child: Chip(
        backgroundColor: const Color(0xfff2f2f2),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        label: Text(
          technology,
          style: const TextStyle(
            fontFamily: "GoogleSans",
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
