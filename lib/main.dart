import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/utilities/constants.dart';
import 'package:myapp/screens/welcome_screen.dart';
import 'package:myapp/screens/register_screen.dart';
import 'package:myapp/screens/signin_screen.dart';
import 'package:myapp/screens/walkie_screen.dart';

void main() => runApp(Walkie());

class Walkie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kColourPrimary,
        scaffoldBackgroundColor: kColourBackground,
        cursorColor: kColourPrimary,
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: kColourPrimary,
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        WalkieScreen.id: (context) => WalkieScreen(),
      },
    );
  }
}
