import 'package:flutter/material.dart';
import 'package:todo_list/modules/authentication/views/login.dart';
import 'package:todo_list/modules/change_password/views/change_password.dart';
import 'package:todo_list/modules/home/views/home.dart';
import 'package:todo_list/modules/profile/views/profile.dart';
import 'package:todo_list/modules/settings/views/settings.dart';
import 'package:todo_list/modules/splash_screen/views/splash_screen.dart';

const String splashScreen = "splashScreen";
const String home = "home";
const String profile = "profile";
const String login = "login";
const String userSettings = "userSettings";
const String changePassword = "changePassword";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case home:
      return MaterialPageRoute(builder: (context) => const Home());
    case profile:
      return MaterialPageRoute(builder: (context) => const Profile());
    case login:
      return MaterialPageRoute(builder: (context) => const Login());
    case userSettings:
      return MaterialPageRoute(builder: (context) => const UserSettings());
    case changePassword:
      return MaterialPageRoute(builder: (context) => const ChangePassword());
    default:
      throw ("Essa rota não existe");
  }
}
