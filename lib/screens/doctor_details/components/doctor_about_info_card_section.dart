import 'package:doc_app/components/info_card.dart';
import 'package:flutter/material.dart';

class DoctorAboutInfoCardSection extends StatelessWidget {
  const DoctorAboutInfoCardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        InfoCard(
          label: 'Patients',
          value: '109',
        ),
        SizedBox(width: 15),
        InfoCard(
          label: 'Experience',
          value: '10 Years',
        ),
        SizedBox(width: 15),
        InfoCard(
          label: 'Rating',
          value: '4.5',
        ),
      ],
    );
  }
}
