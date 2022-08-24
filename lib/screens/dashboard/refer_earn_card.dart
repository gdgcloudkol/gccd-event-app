import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/screens/referral/refer_and_earn_screen.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

///UI for Refer and Earn Card used in [DashboardScreen]

/// {@category Screen}
/// {@subCategory Dashboard}
class ReferEarnCard extends StatelessWidget {
  const ReferEarnCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthBloc ab = Provider.of<AuthBloc>(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const SizedBox(
          height: 200,
        ),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: size.width,
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.gift,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Invite your friends",
                          style: TextStyle(
                            fontFamily: "GoogleSans",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: const TextSpan(
                              text: "Get an ",
                              style: TextStyle(
                                fontFamily: "GoogleSans",
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'exclusive mystery box ',
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: 'for inviting 25 friends.',
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 30,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              primary: Colors.white,
            ),
            onPressed: () {
              if (ab.isLoggedIn) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ReferAndEarn();
                    },
                  ),
                );
              } else {
                showSnackBar(context, "Login to access refer and earn");
              }
            },
            icon: const Icon(
              FontAwesomeIcons.boxOpen,
              color: Colors.black,
            ),
            label: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Refer and earn",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
