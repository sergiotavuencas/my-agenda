import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterScreen> {
  String _userName;
  String _email;
  String _password;
  String _repassword;

  @override
  Widget build(BuildContext context) {
    final snackNotificaion = SnackBar(
        content: Text('Log-in with your new account',
            style: GoogleFonts.robotoSlab(fontSize: 20)));

    final usernameField = Material(
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
              hintText: 'John Doe'
            ),
            onChanged: (value) {
              if (value == "") {
                setState(() {
                  _userName = null;
                });
              } else {
                setState(() {
                  _userName = value;
                });
              }
            },
          ),
        )
      ),
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

    final repasswordField = Material(
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
            ),
            onChanged: (value) {
              if (value == "") {
                setState(() {
                  _repassword = null;
                });
              } else {
                setState(() {
                  _repassword = value;
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
              "Username",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          usernameField,
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "E-mail",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          emailField,
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Password",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          passwordField,
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Re-password",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          repasswordField,
        ],
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoSlab(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: () async {
          try {
            User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _email,
              password: _password,
            )).user;

            if (user != null) {
              user.updateProfile(displayName: _userName);
              Navigator.of(context).pushNamed(AppRoutes.login);
              ScaffoldMessenger.of(context).showSnackBar(snackNotificaion);
            }
          } catch (e) {
            _userName = "";
            _password = "";
            _repassword = "";
            _email = "";
          }
        },
      ),
    );

    final loginButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Already have an account?",
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white )
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.login);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Sign In",
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
                  padding: EdgeInsets.only(top: 40),
                  child: fields,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: loginButton,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: registerButton,
                ),
              ],
            )
          ],
        ),
    );
  }
}
