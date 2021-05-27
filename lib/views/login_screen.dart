import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/theme/app_colors.dart';
import 'package:my_agenda/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginScreen> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final snackNotificaion = SnackBar(
      content: Text('Logged in with Email',
        style: GoogleFonts.robotoSlab(fontSize: 20)
      )
    );

    final emailField = Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 320,
        child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: TextField(
            style: GoogleFonts.robotoSlab(fontSize: 15, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'user@email.com'
            ),
            onChanged: (value) {
              if (value == "") {
                setState(() {
                  _email = null;
                });
              } else {
                setState(() {
                  _email = value;
                });
              }
            },
          ),
        )
      ),
    );

    final passwordField = Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 320,
        child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: TextField(
            obscureText: true,
            style: GoogleFonts.robotoSlab(fontSize: 15, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'www.meeting.link'
            ),
            onChanged: (value) {
              if (value == "") {
                setState(() {
                  _password = null;
                });
              } else {
                setState(() {
                  _password = value;
                });
              }
            },
          ),
        )
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "E-mail",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          emailField,
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Password",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoSlab(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
        onPressed: () async {
          try {
            User user =
              (await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _email,
                password: _password,
              )).user;

            if (user != null) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('displayName', user.displayName);
              Navigator.of(context).pushNamed(AppRoutes.menu);
              ScaffoldMessenger.of(context).showSnackBar(snackNotificaion);
            }
          } catch (e) {
            print(e);
            _email = "";
            _password = "";
          }
        },
      )
    );

    final registerButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Not a member?",
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white )
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.register_user);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Sign Up",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.white, 
                decoration: TextDecoration.underline
              )
            ),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: AppColors().colors[5],
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: fields,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: loginButton,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: registerButton,
                ),
              ],
            )
          ],
        ),
    );
  }
}
