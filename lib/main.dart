import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:si2_parcialito2/api/firebase_api.dart';
import 'package:si2_parcialito2/firebase_options.dart';
import 'package:si2_parcialito2/screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
