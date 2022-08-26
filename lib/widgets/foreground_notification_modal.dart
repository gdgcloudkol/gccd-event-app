import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ForegroundNotificationModal extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String? redirect;
  final String body;
  final String? screen;
  final NavigationBloc nb;

  const ForegroundNotificationModal({
    required this.title,
    required this.body,
    required this.nb,
    this.screen,
    this.imageUrl,
    this.redirect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
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
                    fontSize: 21,
                    fontFamily: "GoogleSans",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          if ((imageUrl ?? "").isNotEmpty)
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 250,
                    width: size.width,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        imageUrl ?? "",
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: size.width - 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.black38,
                    ),
                    child: Center(
                      child: Text(
                        body,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
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
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: const Color(0xff3b82f6),
              ),
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
                height: 60,
                child: Center(
                  child: Text(
                    "Check Now",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      fontFamily: "GoogleSans",
                    ),
                  ),
                ),
              ),
            )
          else if (redirect != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: const Color(0xff3b82f6),
              ),
              onPressed: () {
                launchUrlString(
                  redirect ?? "",
                  mode: LaunchMode.externalApplication,
                );
              },
              child: const SizedBox(
                height: 60,
                child: Center(
                  child: Text(
                    "Check Now",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      fontFamily: "GoogleSans",
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
