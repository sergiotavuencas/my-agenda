import 'package:flutter/material.dart';
import 'package:my_agenda/views/login_screen.dart';
import 'package:my_agenda/views/menu_screen.dart';
import 'package:my_agenda/views/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String register = '/register';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> define() {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      menu: (context) => MenuScreen(),
    };
  }
}