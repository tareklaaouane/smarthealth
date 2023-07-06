import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/screens/doctorProfile.dart';
import 'package:health_and_doctor_appointment/screens/firebaseAuth.dart';
import 'package:health_and_doctor_appointment/mainPage.dart';
import 'package:health_and_doctor_appointment/screens/myAppointments.dart';
import 'package:health_and_doctor_appointment/screens/skip.dart';
import 'package:health_and_doctor_appointment/screens/userProfile.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _auth.currentUser,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Firebase initialization in progress, return a loading screen
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // User is logged in, return MainPage
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => MainPage(),
              '/login': (context) => FireBaseAuth(),
              '/home': (context) => MainPage(),
              '/profile': (context) => UserProfile(),
              '/MyAppointments': (context) => MyAppointments(),
              '/DoctorProfile': (context) => DoctorProfile(),
            },
            theme: ThemeData(brightness: Brightness.light),
            debugShowCheckedModeBanner: false,
          );
        } else {
          // User is not logged in, return Skip
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => Skip(),
              '/login': (context) => FireBaseAuth(),
              '/home': (context) => MainPage(),
              '/profile': (context) => UserProfile(),
              '/MyAppointments': (context) => MyAppointments(),
              '/DoctorProfile': (context) => DoctorProfile(),
            },
            theme: ThemeData(brightness: Brightness.light),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}
