import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class RegisterSubjectScreen extends StatefulWidget {
  @override
  _RegisterSubjectViewState createState() => _RegisterSubjectViewState();
}

class _RegisterSubjectViewState extends State<RegisterSubjectScreen> {
  List<Color> appColors = AppColors().colors;

  final auth = FirebaseAuth.instance;

  String _collection;
  String _type;
  String _date;

  String subject;
  String weekDay;
  String hour;
  String meetingLink;

  @override
  Widget build(BuildContext context) {
    _collection = auth.currentUser.uid;
    _type = "Subjects";
    _date = (new DateTime.now()).toString();

    final subjectField = Container(
      width: 325,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "Math",
          labelText: "Subject",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        onChanged: (value) {
          if (value == "") {
            setState(() {
              subject = null;
            });
          } else {
            setState(() {
              subject = value;
            });
          }
        },
      ),
    );

    final weekDayField = Container(
        width: 325,
        child: TextField(
          decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "Monday",
          labelText: "Week Day",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
          onChanged: (value) {
            if (value == "") {
              setState(() {
                weekDay = null;
              });
            } else {
              setState(() {
                weekDay = value;
              });
            }
          },
        ));

    final hourField = Container(
      width: 325,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "20h00",
          labelText: "Hour",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        onChanged: (value) {
          if (value == "") {
            setState(() {
              hour = null;
            });
          } else {
            setState(() {
              hour = value;
            });
          }
        },
      ),
    );

    final meetingLinkField = Container(
      width: 325,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "meeting.com",
          labelText: "Meeting Link",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        onChanged: (value) {
          if (value == "") {
            setState(() {
              meetingLink = null;
            });
          } else {
            setState(() {
              meetingLink = value;
            });
          }
        },
      ),
    );

    final saveButton = Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(30),
      color: appColors[0],
      child: MaterialButton(
        minWidth: 250,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add Subject",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        onPressed: () async {
          if (subject != null &&
              weekDay != null &&
              hour != null &&
              meetingLink != null) {
            FirebaseFirestore.instance
                .collection(_type + "-" + _collection)
                .doc(_date)
                .set({
                  "subject": subject,
                  "weekDay": weekDay,
                  "hour": hour,
                  "meetingLink": meetingLink,
                })
                .then((value) => print("foi"))
                .catchError((error) => print(error));

            Navigator.of(context).pushNamed(AppRoutes.subjects);
          }
        },
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          subjectField,
            weekDayField,
            hourField,
            meetingLinkField,
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(AppRoutes.subjects);
      },
      child: Scaffold(
        backgroundColor: appColors[7],
        appBar: AppBar(
          backgroundColor: appColors[0],
          centerTitle: true,
          leading: new Container(),
          title: Text(
            "New Subject",
            style: GoogleFonts.robotoSlab(
              fontSize: 30,
            ),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                fields,
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: saveButton,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
