import 'package:crud_app/Utils/Routes/routenames.dart';
import 'package:flutter/material.dart';
import 'Utils/Routes/routecontroler.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: RouteName.homePageRoute,
      onGenerateRoute: RouteControler.generateRoute,
    );
  }
}
