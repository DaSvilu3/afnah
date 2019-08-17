import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

void main() => runApp(MyApp());

const Color greenColor = const Color(0xffB5DE7F);
const Color orangeColor = const Color(0xffFFC729);
const Color redColor = const Color(0xffFF826E);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: redColor
      ),
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(
          seconds: 4,
          navigateAfterSeconds: new DashboardPage(),
          title: new Text('مرحبا بكم في تطبيق أفناه'),
          image: new Image.asset('assets/logos/plain.png'),

          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red
      ),
    );
  }
}

