
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:catalog/view/landing.dart';
import 'package:catalog/view/favourite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitDown,
      // DeviceOrientation.portraitUp
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft
    // ]);

    return MaterialApp(
      title: 'Cat-a-log',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const Landing(),
        'favourite/' : (context) => const Favourite(),
      },
    );
  }
}
