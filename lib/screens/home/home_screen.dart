import 'dart:convert';

import 'package:doc_app/components/components.dart';
import 'package:doc_app/providers/dio_provider.dart';
import 'package:doc_app/screens/screens.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> user = {};

  List<Map<String, dynamic>> medicalCategories = [
    {
      'icon': FontAwesomeIcons.userDoctor,
      'category': 'General',
    },
    {
      'icon': FontAwesomeIcons.heartPulse,
      'category': 'Cardiology',
    },
    {
      'icon': FontAwesomeIcons.lungs,
      'category': 'Respirations',
    },
    {
      'icon': FontAwesomeIcons.hand,
      'category': 'Dermatology',
    },
    {
      'icon': FontAwesomeIcons.personPregnant,
      'category': 'Gynecology',
    },
    {
      'icon': FontAwesomeIcons.teeth,
      'category': 'Dental',
    },
  ];

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getUser(token: token);
      if (response != null) {
        setState(() {
          user = json.decode(response);
          debugPrint('USER: $user');
        });
      }
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 16,
          right: 16,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                    )
                  ],
                ),
                Config.spaceSmall,
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize * 0.06,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: List.generate(
                      medicalCategories.length,
                      (index) => Card(
                        margin: const EdgeInsets.only(
                          right: 20,
                        ),
                        color: Config.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FaIcon(
                                  medicalCategories[index]['icon'],
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  medicalCategories[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Appointment Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                const AppointmentCard(),
                Config.spaceSmall,
                const Text(
                  'Top Doctors',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                Column(
                  children: List.generate(
                    10,
                    (index) => const DoctorCard(
                      route: '/doctor-details',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
