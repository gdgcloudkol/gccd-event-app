import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/referral_bloc.dart';
import 'package:ccd2022app/widgets/custom_inputfields.dart';
import 'package:ccd2022app/widgets/indicator_heading.dart';
import 'package:flutter/material.dart';

import '../../utils/snackbar.dart';

class ReferralCodeInput extends StatelessWidget {
  ReferralCodeInput({Key? key, required this.rb, required this.ab, required this.nb})
      : super(key: key);

  final TextEditingController referralCodeController = TextEditingController();
  final FocusNode referralNode = FocusNode();
  final ReferralBloc rb;
  final NavigationBloc nb;
  final AuthBloc ab;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        const IndicatorHeading(
          title: "Enter referral Code",
          indicatorColor: Colors.blue,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Got a Referral Code from a friend or a contact? Enter it here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 25, left: 25, bottom: 25),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: buildInputField(
                            "Referral Code",
                            "",
                            TextInputType.text,
                            referralCodeController,
                            context,
                            true,
                            referralNode,
                            null,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Tooltip(
                              message: "Submit",
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const CircleBorder(),
                                  elevation: 5,
                                ),
                                onPressed: () async {
                                  if (referralCodeController.text.isEmpty) {
                                    showSnackBar(
                                      context,
                                      "Referral code can't be empty",
                                    );
                                    return;
                                  }
                                   await rb.createNewReferral(
                                    ab.uid,
                                    referralCodeController.text,
                                    ab,
                                    nb,
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 60,
                                  child: const Icon(
                                    Icons.arrow_circle_right,
                                    color: Color(0xff93b5f1),
                                    size: 45,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
