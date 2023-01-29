import 'package:doc_app/screens/screens.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';

class DoctorProfileDetailsSection extends StatelessWidget {
  const DoctorProfileDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DoctorAboutInfoCardSection(),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Config.spaceSmall,
          const Text(
            'Dr. Richard Tan is an emergency medicine physician in New York, '
            'New York. He received his medical degree from University of '
            'Vermont College of Medicine.',
            style: TextStyle(
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
