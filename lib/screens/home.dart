import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String code;

  const HomeScreen({super.key, required this.code});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Handle the parsing and provide a fallback color in case of an error
    Color backgroundColor;
    try {
      backgroundColor = Color(int.parse(widget.code));
    } catch (e) {
      // Fallback color in case of an error
      backgroundColor = Colors.white;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text("#${widget.code.substring(4)}",
            style: const TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }
}
