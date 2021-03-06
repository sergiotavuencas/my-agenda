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
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Widget build(BuildContext context) {
    final snackNotificaion = SnackBar(content: Text('Logged in with Google', style: GoogleFonts.robotoSlab(fontSize: 20)));

    final logo = Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(90),
      color: Colors.transparent,
      child: Image.asset(
        "assets/MyAgenda.png",
        height: 200,
        width: 200,
      ),
    );

    final emailSignUpButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          children: [
            Text(
              "Sign Up with e-mail",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
                size: 30,
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.register_user);
        },
      ),
    );

    final emailLoginButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          children: [
            Text(
              "Login with e-mail",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.mail,
                color: Colors.black,
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
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          children: [
            Text(
              "Login with Google",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        onPressed: () async {
          try {
            User user = await GoogleAuthentication.signInWithGoogle();

            if (user != null) {
              Navigator.of(context).pushNamed(AppRoutes.menu);
              ScaffoldMessenger.of(context).showSnackBar(snackNotificaion);
            }
          } catch (e) {
            print("Error on sign-in with Google: " + e);
          }
        },
      ),
    );

    return Scaffold(
      backgroundColor: AppColors().colors[4],
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
                      style: GoogleFonts.robotoSlab(
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
                  padding: EdgeInsets.only(top: 40),
                  child: emailSignUpButton,
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
