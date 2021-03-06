import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';
import 'package:intl/intl.dart';

class RegisterDateScreen extends StatefulWidget {
  @override
  _RegisterDateViewState createState() => _RegisterDateViewState();
}

class _RegisterDateViewState extends State<RegisterDateScreen> {
  final auth = FirebaseAuth.instance;

  String _collection;
  String _type;
  String _date;

  String event;
  String subject;
  DateTime pickedDate;
  String description;

  @override
  Widget build(BuildContext context) {
    final snackNotificaion = SnackBar(
        content: Text('Added a new Date',
            style: GoogleFonts.robotoSlab(fontSize: 20)));

    _collection = auth.currentUser.uid;
    _type = "Dates";
    _date = (new DateTime.now()).toString();

    final eventField = Material(
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
              hintText: 'Math exam'
            ),
            onChanged: (value) {
              if (value == "") {
                setState(() {
                  event = null;
                });
              } else {
                setState(() {
                  event = value;
                });
              }
            },
          ),
        )
      ),
    );

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

    final descriptionField = Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      child: Container(
        width: 320,
        child: Padding(
          padding: EdgeInsets.only(left: 30),
          child: TextField(
            maxLines: 2,
            style: GoogleFonts.robotoSlab(fontSize: 15, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Study sum'
            ),
            onChanged: (value) {
              if (value == "") {
                setState(() {
                  description = null;
                });
              } else {
                setState(() {
                  description = value;
                });
              }
            },
          ),
        )
      ),
    );

    final dateField = Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          MaterialButton(
              minWidth: 100,
              height: 50,
              color: AppColors().colors[2],
              child: Icon(FontAwesomeIcons.calendarAlt, color: Colors.white),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2022))
                    .then((date) {
                  setState(() {
                    pickedDate = date;
                  });
                });
              }),
          Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pickedDate == null
                        ? 'Pick a date'
                        : DateFormat('MM-dd-yyyy').format(pickedDate).toString(),
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
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
          children: [
            Text(
              "Add Date",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onPressed: () async {
          if (event != null &&
              subject != null &&
              pickedDate.toString() != 'Pick a date' &&
              description != null) {
            FirebaseFirestore.instance
                .collection(_type + "-" + _collection)
                .doc(_date.toString())
                .set({
                  "event": event,
                  "subject": subject,
                  "date": DateFormat('MM-dd').format(pickedDate),
                  "description": description
                })
                .then((value) => print("foi"))
                .catchError((error) => print(error));

            Navigator.of(context).pushNamed(AppRoutes.dates);
            ScaffoldMessenger.of(context).showSnackBar(snackNotificaion);
          }
        },
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Text(
                "Event",
                style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ],
          ),
          eventField,
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Subject",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            ),
          ),
          subjectField,
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Description",
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
            ),
          ),
          descriptionField,
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: dateField,
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(AppRoutes.dates);
      },
      child: Scaffold(
        backgroundColor: AppColors().colors[7],
        appBar: AppBar(
          backgroundColor: AppColors().colors[0],
          centerTitle: true,
          leading: new Container(),
          title: Text(
            "New Date",
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
