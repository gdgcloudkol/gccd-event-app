import 'package:flutter/material.dart';

class SponsorsCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String descriptionColor;

  const SponsorsCard({
    Key? key,
    required this.imageUrl,
    required this.descriptionColor,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 5,
              ),
              Image.network(
                imageUrl,
                height: 50,
              ),
              Container(
                width: size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: getColorFromStr(descriptionColor),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorFromStr(String valueString) {
    int value = int.parse("FF$valueString", radix: 16);
    Color color = Color(value);
    return color;
  }
}
