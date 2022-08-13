import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/screens/dashboard/application_status_card.dart';
import 'package:ccd2022app/screens/dashboard/refer_earn_card.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthBloc ab = Provider.of<AuthBloc>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Hello,",
              style: TextStyle(
                fontFamily: "GoogleSans",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            Text(
              ab.name,
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const ApplicationStatusCard(),
            const SizedBox(
              height: 30,
            ),
            if (!DateTime.now().isAfter(Config.referralContestLastDate)) ...[
              const Text(
                "Contests 🎁",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const ReferEarnCard(),
            ]
          ],
        ),
      ),
    );
  }
}
