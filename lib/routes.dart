import 'package:flutter/material.dart';
import 'package:my_agenda/views/dates_screen.dart';
import 'package:my_agenda/views/login_screen.dart';
import 'package:my_agenda/views/menu_screen.dart';
import 'package:my_agenda/views/register_date_screen.dart';
import 'package:my_agenda/views/register_subject_screen.dart';
import 'package:my_agenda/views/register_user_screen.dart';
import 'package:my_agenda/views/subjects_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String register_user = '/register_user';
  static const String menu = '/menu';
  static const String dates = '/dates';
  static const String subjects = '/subjects';
  static const String register_date = '/register_date';
  static const String register_subject = '/register_subject';

  static Map<String, WidgetBuilder> define() {
    return {
      login: (context) => LoginScreen(),
      register_user: (context) => RegisterScreen(),
      menu: (context) => MenuScreen(),
      dates: (context) => DatesScreen(),
      subjects: (context) => SubjectsScreen(),
      register_date: (context) => RegisterDateScreen(),
      register_subject: (context) => RegisterSubjectScreen(),
    };
  }
}