import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class RegisterSubjectScreen extends StatefulWidget {
  @override
  _RegisterSubjectViewState createState() => _RegisterSubjectViewState();
}

class _RegisterSubjectViewState extends State<RegisterSubjectScreen> {
  final auth = FirebaseAuth.instance;

  String _collection;
  String _type;
  String _date;
  TimeOfDay _time;

  String subject;
  String weekDay;
  TimeOfDay pickedTime;
  String meetingLink;

  @override
  Widget build(BuildContext context) {
    final snackNotificaion = SnackBar(
        content: Text('Added a new Subject',
            style: GoogleFonts.robotoSlab(fontSize: 20)));

    _collection = auth.currentUser.uid;
    _type = "Subjects";
    _date = (new DateTime.now()).toString();

    List<String> weekDays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    Future<Null> selectTime(BuildContext context) async {
      pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      setState(() {
        _time = pickedTime;
      });
    }

    final subjectField = Material(
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
              hintText: 'Math'
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
        )
      ),
    );

    final weekDayField = Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors().colors[2],
      child: Container(
        width: 325,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: Text(
                  "Week Day",
                  style: GoogleFonts.robotoSlab(fontSize: 25, color: Colors.white),
                ),
            ),
            DropdownButton(
              dropdownColor: AppColors().colors[5],
              value: weekDay,
              onChanged: (newValue) {
                setState(() {
                  weekDay = newValue;
                });
              },
              items: weekDays.map((location) {
                return DropdownMenuItem(
                  child: new Text(
                    location, 
                    style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white)
                  ),
                  value: location,
                );
              }).toList(),
            )
          ],
        )
      ),
    );

    final meetingLinkField = Material(
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
              hintText: 'www.meeting.link'
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
        )
      ),
    );

    final timeField = Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors().colors[2],
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: MaterialButton(
              minWidth: 50,
              height: 50,
              color: AppColors().colors[2],
              child: Icon(FontAwesomeIcons.clock, color: Colors.white),
              onPressed: () {
                selectTime(context);
              }
            ),
          ),
          Container(
              width: 255,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pickedTime == null
                        ? 'Pick a time'
                        : (_time.hour.toString().length <= 1 ? "0" + _time.hour.toString() : _time.hour.toString()) + ":" 
                        + (_time.minute.toString().length <= 1 ? "0" + _time.minute.toString() : _time.minute.toString()),
                    style: GoogleFonts.robotoSlab(
                        fontSize: 30, color: Colors.white),
                        
                  ),
                ],
              )),
        ],
      ),
    );

    final saveButton = Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add Subject",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onPressed: () async {
          if (subject != null &&
              weekDay != null &&
              pickedTime.toString() != 'Pick a time' &&
              meetingLink != null) {
            FirebaseFirestore.instance
                .collection(_type + "-" + _collection)
                .doc(_date)
                .set({
                  "subject": subject,
                  "weekDay": weekDay,
                  "hour": (_time.hour.toString().length <= 1 ? "0" + _time.hour.toString() : _time.hour.toString()) + ":" 
                        + (_time.minute.toString().length <= 1 ? "0" + _time.minute.toString() : _time.minute.toString()),
                  "meetingLink": meetingLink,
                })
                .then((value) => print("foi"))
                .catchError((error) => print(error));

            Navigator.of(context).pushNamed(AppRoutes.subjects);
            ScaffoldMessenger.of(context).showSnackBar(snackNotificaion);
          }
        },
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Subject",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          subjectField,
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Meeting Link",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            )
          ),
          meetingLinkField,
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: weekDayField
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: timeField,
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(AppRoutes.subjects);
      },
      child: Scaffold(
        backgroundColor: AppColors().colors[7],
        appBar: AppBar(
          backgroundColor: AppColors().colors[0],
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
                  padding: EdgeInsets.only(top: 30),
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
