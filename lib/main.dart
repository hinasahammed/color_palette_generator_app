import 'package:color_palette_generator_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: "Random Color Generator",
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
