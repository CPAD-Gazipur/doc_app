import 'package:doc_app/components/info_card.dart';
import 'package:flutter/material.dart';

class DoctorAboutInfoCardSection extends StatelessWidget {
  final Map doctor;

  const DoctorAboutInfoCardSection({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoCard(
          label: 'Patients',
          value: doctor['patients'] != null
              ? doctor['patients'].toString()
              : 'N/A',
        ),
        const SizedBox(width: 15),
        InfoCard(
          label: 'Experience',
          value: doctor['experience'] != null
              ? doctor['experience'] == 1
                  ? '${doctor['experience']} Year'
                  : '${doctor['experience']} Years'
              : 'N/A',
        ),
        const SizedBox(width: 15),
        InfoCard(
          label: 'Rating',
          value: doctor['average_ratings'] != null
              ? doctor['average_ratings'].toStringAsFixed(1)
              : 'N/A',
        ),
      ],
    );
  }
}
