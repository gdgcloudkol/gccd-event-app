import 'package:ccd2022app/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Cloud Community Days 2022",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "A community organized cloud conference with industry experts presenting on exciting topics!",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Organized by",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/Logo.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "GDG Cloud Kolkata",
                    style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff666666)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Dates: 27th-28th August",
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    fontSize: 20,
                    color: Color(0xff666666)),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff3b82f6),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const FormScreen();
                      },
                    ),
                  );
                },
                child: const SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Reserve your seat",
                      style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff16a34a),
                ),
                onPressed: () {
                  launchUrlString(
                    "https://sessionize.com/cloud-community-days",
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Become a Speaker",
                      style: TextStyle(
                          fontFamily: "GoogleSans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
