import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class RegisterDateScreen extends StatefulWidget {
  @override
  _RegisterDateViewState createState() => _RegisterDateViewState();
}

class _RegisterDateViewState extends State<RegisterDateScreen> {
  List<Color> appColors = AppColors().colors;

  final auth = FirebaseAuth.instance;

  String _collection;
  String _type;
  String _date;

  String event;
  String subject;
  String date;
  String description;

  @override
  Widget build(BuildContext context) {
    _collection = auth.currentUser.uid;
    _type = "Dates";
    _date = (new DateTime.now()).toString();

    final eventField = Container(
      width: 325,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "Math Project",
          labelText: "Event",
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
              event = null;
            });
          } else {
            setState(() {
              event = value;
            });
          }
        },
      ),
    );

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

    final dateField = Container(
      width: 325,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "day-month-year",
          labelText: "Date",
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
              date = null;
            });
          } else {
            setState(() {
              date = value;
            });
          }
        },
      ),
    );

    final descriptionField = Container(
      width: 325,
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: "Write only the answers",
          labelText: "Description",
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
              description = null;
            });
          } else {
            setState(() {
              description = value;
            });
          }
        },
      ),
    );

    final saveButton = Material(
      elevation: 15,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      color: appColors[0],
      child: MaterialButton(
        minWidth: 250,
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
          children: [
            Text(
              "Add Date",
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        onPressed: () async {
          if (event != null &&
              subject != null &&
              date != null &&
              description != null) {
            FirebaseFirestore.instance
                .collection(_type + "-" + _collection)
                .doc(_date)
                .set({
                  "event": event,
                  "subject": subject,
                  "date": date,
                  "description": description
                })
                .then((value) => print("foi"))
                .catchError((error) => print(error));

            Navigator.of(context).pushNamed(AppRoutes.dates);
          }
        },
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          eventField,
          subjectField,
          dateField,
          descriptionField,
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(AppRoutes.dates);
      },
      child: Scaffold(
        backgroundColor: appColors[7],
        appBar: AppBar(
          backgroundColor: appColors[0],
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
