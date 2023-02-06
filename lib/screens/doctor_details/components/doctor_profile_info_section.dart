import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorProfileInfoSection extends StatelessWidget {
  final Map doctor;

  const DoctorProfileInfoSection({Key? key, required this.doctor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage(
                'http://127.0.0.1:8000${doctor['doctor_profile']}'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              doctor['doctor_name'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
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
