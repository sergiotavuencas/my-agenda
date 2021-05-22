import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/theme/app_colors.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuScreen> {
  List<Color> appColors = AppColors().colors;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: new Container(),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  print('exit');
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, "/");
                })
          ],
        ),
        backgroundColor: appColors[5],
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
                        auth.currentUser.displayName,
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
