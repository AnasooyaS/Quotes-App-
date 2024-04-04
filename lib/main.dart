import 'package:flutter/material.dart';
import 'package:quotes_app/pages/first_page.dart';
import 'package:quotes_app/pages/quotes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const FirstScreen(),
    );
  }
}
