import 'package:crud_app/Screens/addlist.dart';
import 'package:crud_app/Screens/getlist.dart';
import 'package:flutter/material.dart';
import 'routenames.dart';

class RouteControler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homePageRoute:
        {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        }
      case RouteName.addPageRoute:
        {
          return MaterialPageRoute(
            builder: (context) => AddPage(),
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                  title: const Center(
                child: Text("No route Found"),
              )),
            ),
          );
        }
    }
  }
}
