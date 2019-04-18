import 'package:flutter/material.dart';
import 'package:moda/page/anasayfa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Anasayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}