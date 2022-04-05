import 'package:flutter/material.dart';
import 'package:menejo_archivos/src/Home_Page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menejo Archivos',
      home: homePage(),
    );
  }
}