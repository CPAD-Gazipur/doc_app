import 'package:doc_app/screens/doctor_details/components/doctor_about_info_section.dart';
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
        children: const [
          Config.spaceSmall,
          DoctorAboutInfoSection(),
        ],
      ),
    );
  }
}
