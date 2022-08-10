import 'dart:io';

import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Refer and Earn",
          style: TextStyle(
              color: Colors.black87, fontFamily: 'GoogleSans', fontSize: 20),
        ),
      ),
      body: Column(
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
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: _copyToClipboard,
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final bytes = await rootBundle.load('assets/images/share.png');
              final list = bytes.buffer.asUint8List();

              final tempDir = await getTemporaryDirectory();
              final file =
                  await File('${tempDir.path}/Cloud Community Days 2022.jpg')
                      .create();
              file.writeAsBytesSync(list);
              Share.shareFiles(
                [file.path],
                subject: "Cloud Community Days Kolkata 2022",
                text:
                    "Hey! Let's join together for the largest developer conclave "
                    "in eastern India - Cloud Community Days Kolkata to"
                    " join hundreds of developers and engage with industry experts presenting on cutting edge technology."
                    'Hurry, get your pass!\n'
                    '\nWebsite: https://gdgcloud.kolkata.dev/ccd2022/\n\n'
                    'App: https://play.google.com/store/apps/details?id=com.gdgck.ccd2022',
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            label: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0,
              ),
              child: Text(
                'Share',
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
