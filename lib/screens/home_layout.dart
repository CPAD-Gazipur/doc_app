import 'package:doc_app/screens/appointment_screen.dart';
import 'package:doc_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentScreen = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentScreen = value;
          });
        },
        children: const [
          HomeScreen(),
          AppointmentScreen(),
        ],
      ),
    );
  }
}
