import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String id = "registration_screen";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String password = "";

  ///Use this provider instance to access business logic and maintain state

  @override
  Widget build(BuildContext context) {
    AuthBloc lb = Provider.of<AuthBloc>(context);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Hero(
              tag: "logo",
              child: Image(
                image: AssetImage('assets/images/Logo.png'),
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  SizedBox(
                    width: queryData.size.width * 0.8,
                    child: TextFormField(
                      autofocus: false,
                      decoration:
                          const InputDecoration().copyWith(labelText: "Email"),
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                          if (kDebugMode) {
                            print(email);
                          }
                        });
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(15)),
                  SizedBox(
                    width: queryData.size.width * 0.8,
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                          if (kDebugMode) {
                            print(password);
                          }
                        });
                      },
                      decoration: const InputDecoration()
                          .copyWith(labelText: "Password"),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                    onPressed: () {
                      try {
                        lb.signUpWithEmailPassword(
                            email.toString().trim(), password);
                      } catch (e) {
                        if (kDebugMode) {
                          print(lb.errorMessage);
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 1.0,
                      minimumSize: Size(queryData.size.width * 0.6,
                          queryData.size.height * 0.06),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Already have account? ',
                        ),
                        TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: Colors.orangeAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              }),
                      ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
