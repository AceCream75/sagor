import 'package:flutter/material.dart';
import 'package:uthao1/AllScreens/loginScreen.dart';
import 'package:uthao1/AllScreens/mainscreen.dart';
import 'package:uthao1/AllScreens/registrationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTHAO',
      theme: ThemeData(
        fontFamily: "Brand-Regular",
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.idScreen,
      routes:
      {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => RegistrationScreen(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

