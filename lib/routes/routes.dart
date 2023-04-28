import 'package:flutter/material.dart';
import 'package:todo_list/routes/views/splash_screen.dart';

const String splashScreen = "splashScreen";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    default:
      throw ("Essa rota não existe");
  }
}
