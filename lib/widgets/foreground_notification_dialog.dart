import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForegroundNotificationDialog extends StatelessWidget {
  final String title;
  final String body;
  final String? screen;
  final NavigationBloc nb;

  const ForegroundNotificationDialog({
    required this.title,
    required this.body,
    required this.nb,
    this.screen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.solidBell,
                  color: Colors.amber,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontFamily: "GoogleSans",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            // Image.asset(
            //   "assets/images/alert.gif",
            //   height: 100,
            //   width: 100,
            // ),

            const SizedBox(
              height: 20,
            ),
            Text(
              body,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "GoogleSans",
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            if (screen != null && nb.screenNames.values.contains(screen))
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
                onPressed: () {
                  int navIndex = nb.screenNames.keys.firstWhere(
                    (k) => nb.screenNames[k] == screen,
                    orElse: () => -1,
                  );

                  if (navIndex != -1) {
                    nb.changeNavIndex(navIndex);
                    Navigator.pop(context);
                  }
                },
                child: const SizedBox(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      "Check Now",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "GoogleSans",
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
