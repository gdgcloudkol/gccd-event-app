import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);
  static const String routeName = 'refer_and_earn';

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  @override
  Widget build(BuildContext context) {
    AuthBloc ab = Provider.of<AuthBloc>(context);
    final TextEditingController _textController = TextEditingController(
      text: ab.uid,
    );

    // This function is triggered when the copy icon is pressed
    Future<void> _copyToClipboard() async {
      await Clipboard.setData(ClipboardData(text: _textController.text));
      showSnackBar(context, 'Copied to clipboard');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.blue,
                ),
                width: 10,
                height: 70,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Refer and Earn",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
        Image.asset(
          "assets/images/refer.png",
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            "Invite 25 friends to get an exclusive mystery box.\n\nYour referral code is:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _textController,
            readOnly: true,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: _copyToClipboard,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
