import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_agenda/theme/app_colors.dart';
import 'package:my_agenda/googleAuthentication.dart';
import 'package:my_agenda/routes.dart';

class OpeningView extends StatefulWidget {
  @override
  OpeningViewState createState() => OpeningViewState();
}

class OpeningViewState extends State<OpeningView> {
  List<Color> appColors = AppColors().colors;

  final logo = Image.asset(
    "assets/MyAgenda.png",
    height: 200,
    width: 200,
  );

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Widget build(BuildContext context) {
    final emailLoginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: appColors[4],
      child: MaterialButton(
        minWidth: 225,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          children: [
            Text(
              "Login with e-mail",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.login);
        },
      ),
    );

    final googleLoginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.black,
      child: MaterialButton(
        minWidth: 225,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          children: [
            Text(
              "Login with Google",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
                size: 25,
              ),
            )
          ],
        ),
        onPressed: () async {
          try {
            User user = await GoogleAuthentication.signInWithGoogle();

            if(user != null) {
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          } catch (e) {
            print("Error on sign-in with Google: " + e);
          }
        },
      ),
    );

    return Scaffold(
      backgroundColor: appColors[7],
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      "Welcome to",
                      style: GoogleFonts.roboto(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: logo,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: emailLoginButton,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: googleLoginButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}