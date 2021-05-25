import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/theme/app_colors.dart';

class DatesScreen extends StatefulWidget {
  @override
  _DatesViewState createState() => _DatesViewState();
}

class _DatesViewState extends State<DatesScreen> {
  final auth = FirebaseAuth.instance;

  String _collection;

  @override
  Widget build(BuildContext context) {
    _collection = auth.currentUser.uid;

    Widget datesList() {
      getListItems(AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.data.docs
            .map((doc) => new Padding(
                padding: EdgeInsets.only(top: 20),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors().colors[2],
                  child: Container(
                    width: 230,
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doc["date"],
                          style: GoogleFonts.robotoSlab(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              doc["event"],
                              style: GoogleFonts.robotoSlab(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              doc["subject"],
                              style: GoogleFonts.robotoSlab(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              doc["description"],
                              style: GoogleFonts.robotoSlab(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Icon(FontAwesomeIcons.angleLeft,
                            size: 20, color: Colors.transparent),
                      ],
                    ),
                  ),
                )))
            .toList();
      }

      return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Dates-" + _collection)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Searching...",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 30,
                        color: Colors.white
                      ),
                    )
                  ],
                );
              }
              return new ListView(children: getListItems(snapshot));
            }),
      );
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(AppRoutes.menu);
      },
      child: Scaffold(
        backgroundColor: AppColors().colors[6],
        appBar: AppBar(
          backgroundColor: AppColors().colors[0],
          centerTitle: true,
          leading: new Container(),
          title: Text(
            "Dates",
            style: GoogleFonts.robotoSlab(
              fontSize: 30,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              datesList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors().colors[0],
          child: Icon(Icons.add, size: 40),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.register_date);
          },
        ),
      ),
    );
  }
}
