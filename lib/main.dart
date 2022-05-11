import 'package:flutter/material.dart';
import 'package:mana7yaha/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

const white = Color(0xFFFFFFFF);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: welcome(),
    );
  }
}
