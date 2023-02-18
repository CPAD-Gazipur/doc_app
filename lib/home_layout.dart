import 'package:doc_app/screens/appointment/appointment_screen.dart';
import 'package:doc_app/screens/favorite/favorite_screen.dart';
import 'package:doc_app/screens/home/home_screen.dart';
import 'package:doc_app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          FavoriteScreen(),
          AppointmentScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (page) {
          setState(() {
            currentScreen = page;
            _pageController.animateToPage(
              page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseChimneyMedical),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidHeart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCalendarCheck),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
