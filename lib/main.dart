import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:catalog/model/cart.dart';
import 'package:catalog/view_model/landing.dart';
import 'package:catalog/view_model/cat_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      // DeviceOrientation.portraitDown,
      // DeviceOrientation.portraitUp
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
      title: 'Cat-a-log',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const Landing(),
        '/cat_profile' : (context) => const CatProfile(),
      },
    ),
    );
  }
}
