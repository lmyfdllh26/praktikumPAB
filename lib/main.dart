import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tuzktpmoayxzcywctncv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1emt0cG1vYXl4emN5d2N0bmN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2NTUwOTYsImV4cCI6MjA4OTIzMTA5Nn0.CIFWriLESb_w908cJVKMRHm8Md8-z6TgY519usi2jsE',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cookies App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}