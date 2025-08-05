import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'AddNote.dart';
import 'HomePage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // دي أهم حاجة
    );
  }
}
