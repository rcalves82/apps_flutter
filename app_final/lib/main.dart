import 'package:app_final/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

/*void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}*/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IGTI CarWashing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'IGTI CarWashing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: [
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white70,
            Colors.white
          ],
        ),
        navigateAfterSeconds: Home(),
        loaderColor: Colors.white,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/iconeDesafioFinal.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}