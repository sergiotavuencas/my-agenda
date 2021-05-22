import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_agenda/routes.dart';
import 'package:my_agenda/views/opening_screen.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Agenda',
      routes: AppRoutes.define(),
      home: OpeningView(),
    );
  }
}
