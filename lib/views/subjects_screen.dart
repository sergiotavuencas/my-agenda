import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsViewState createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsScreen> {
  List<Color> appColors = AppColors().colors;

  final auth = FirebaseAuth.instance;

  String _collection;

  @override
  Widget build(BuildContext context) {
    _collection = auth.currentUser.uid;

    Widget subjectsList() {
      getListItems(AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.data.docs
            .map((doc) => new Padding(
                padding: EdgeInsets.only(top: 20),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(80),
                  color: appColors[2],
                  child: Container(
                    width: 230,
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          doc["subject"],
                          style: GoogleFonts.robotoSlab(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          doc["weekDay"] + " " + doc["hour"],
                          style: GoogleFonts.robotoSlab(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            doc["meetingLink"],
                            style: GoogleFonts.robotoSlab(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )))
            .toList();
      }

      return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Subjects-" + _collection)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("No documents");
              return new ListView(children: getListItems(snapshot));
            }),
      );
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(AppRoutes.menu);
      },
      child: Scaffold(
        backgroundColor: appColors[6],
        appBar: AppBar(
          backgroundColor: appColors[0],
          centerTitle: true,
          leading: new Container(),
          title: Text(
            "Subjects",
            style: GoogleFonts.robotoSlab(
              fontSize: 30,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              subjectsList()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appColors[0],
          child: Icon(Icons.add, size: 40),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.register_subject);
          },
        ),
      ),
    );
  }
}
