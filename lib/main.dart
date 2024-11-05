import 'package:books_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
