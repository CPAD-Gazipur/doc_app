import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorProfileInfoSection extends StatelessWidget {
  const DoctorProfileInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 65,
            backgroundImage: AssetImage('assets/images/doctor_2.png'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          const Text(
            'Dr Richard Tan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.screenWidth! * 0.75,
            child: const Text(
              'MBBS (International Medical University, Malaysia), '
              'MRCP (Royal College of Physicians, United Kingdom)',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.screenWidth! * 0.75,
            child: const Text(
              'Sarawak General Hospital',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
