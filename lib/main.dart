import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:home_emergency_app/ui/authentication.dart';

void main() async {
  // Implement firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Emergency',
      home: Authentication(),
    );
  }
}
