import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.primaryColor,
            child: Column(
              children: const [
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Sai Pallabi',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '23 Years Old | Female',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: const EdgeInsets.only(top: 45),
                child: Container(
                  height: 250,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blueAccent[400],
                              size: 35,
                            ),
                            const SizedBox(width: 35),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.yellowAccent[400],
                              size: 35,
                            ),
                            const SizedBox(width: 35),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'History',
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.lightGreen[400],
                              size: 35,
                            ),
                            const SizedBox(width: 35),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
