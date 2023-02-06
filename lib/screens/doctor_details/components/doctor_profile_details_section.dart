import 'package:doc_app/screens/screens.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';

class DoctorProfileDetailsSection extends StatelessWidget {
  final Map doctor;

  const DoctorProfileDetailsSection({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DoctorAboutInfoCardSection(
            doctor: doctor,
          ),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Config.spaceSmall,
          Text(
            doctor['bio_data'] ?? '',
            style: const TextStyle(
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.justify,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
