import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: home(),
       theme: ThemeData.dark(),
       // Add error handling for better debugging
       builder: (context, child) {
         return MediaQuery(
           data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
           child: child!,
         );
       },
     );
  }
}