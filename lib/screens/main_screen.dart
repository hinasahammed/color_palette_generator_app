import 'dart:math';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:color_palette_generator_app/screens/account.dart';
import 'package:color_palette_generator_app/screens/favorite.dart';
import 'package:color_palette_generator_app/screens/home.dart';
import 'package:color_palette_generator_app/screens/search.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String colorCode = "";

  @override
  void initState() {
    super.initState();
    colorCode = generateCode();
    updateScreens(); // Ensure screens are initialized with the color code
  }

  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  late List<Widget> screens; // Declare screens as late

  int currentIndex = 0;

  void updateScreens() {
    screens = [
      HomeScreen(code: colorCode), // Use the current colorCode
      SearchScreen(),
      FavoriteScreen(),
      AccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screens[currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff212529),
        child: Icon(
          Icons.refresh,
          color: Color(0xffffffff),
        ),
        shape: CircleBorder(),
        onPressed: () {
          setState(() {
            colorCode = generateCode();
            updateScreens(); // Update screens with the new colorCode
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        backgroundColor: Color(0xff212529),
        activeColor: Colors.white,
        inactiveColor: Colors.white70,
        notchSmoothness: NotchSmoothness.softEdge,
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  String generateCode() {
    String characters = "1234567890abcdef";
    String code = "";

    for (int i = 0; i < 6; i++) {
      code += characters[Random().nextInt(characters.length)];
    }

    print(code);
    return "0xff$code"; // Ensure this returns a valid hex string
  }
}
