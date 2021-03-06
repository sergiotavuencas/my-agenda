import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: AppColors().colors[0],
                      child: Container(
                        width: 350,
                        height: 50,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              doc["date"],
                              style: GoogleFonts.robotoSlab(fontSize: 30, color: Colors.white)
                            ),
                          )
                        )
                      )
                    ),
                    Material(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      color: AppColors().colors[2],
                      child: Container(
                        width: 350,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                doc["event"],
                              style: GoogleFonts.robotoSlab(fontSize: 25, color: Colors.white)
                              ),
                              Text(
                                doc["subject"],
                              style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white)
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  doc["description"],
                                  style: GoogleFonts.robotoSlab(fontSize: 20, color: Colors.white)
                                ),
                              ),
                            ],
                          ),
                        )
                      )
                    ),
                  ],
                )
              )
            )
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
