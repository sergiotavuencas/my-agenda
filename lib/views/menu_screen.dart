import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final snackNotificaion = SnackBar(content: Text('Logged out', style: GoogleFonts.robotoSlab(fontSize: 20)));
    final String userName = auth.currentUser.displayName;

    final profileIcon = Material(
      borderRadius: BorderRadius.circular(80),
      elevation: 5,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.transparent,
        child: Text(
          userName[0],
          style: GoogleFonts.robotoSlab(
            color: AppColors().colors[0],
            fontSize: 100,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final datesButton = Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 10,
      color: AppColors().colors[1],
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.calendarAlt, color: Colors.white),
            Container(
              margin: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Text(
                "Dates",
                style: GoogleFonts.robotoSlab(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(FontAwesomeIcons.angleRight, color: Colors.white),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.dates);
        },
      ),
    );

    final subjectsButton = Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 10,
      color: AppColors().colors[3],
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.list, color: Colors.white),
            Container(
              margin: const EdgeInsets.only(left: 35.0, right: 35.0),
              child: Text(
                "Subjects",
                style: GoogleFonts.robotoSlab(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(FontAwesomeIcons.angleRight, color: Colors.white),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.subjects);
        },
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().colors[0],
          leading: new Container(),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  print('exit');
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, "/");
                  ScaffoldMessenger.of(context).showSnackBar(snackNotificaion);
                })
          ],
        ),
        backgroundColor: AppColors().colors[5],
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        userName,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: profileIcon,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: datesButton,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: subjectsButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
