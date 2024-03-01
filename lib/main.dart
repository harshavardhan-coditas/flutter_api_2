import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radom User',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}
