import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cookies App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 118, 80, 66),
      ),
      home: HomePage(),
    );
  }
}
