import 'package:doc_app/main.dart';
import 'package:doc_app/screens/doctor_details/doctor_details_screen.dart';
import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final bool isFavorite;

  const DoctorCard({
    Key? key,
    required this.doctor,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: () {
          MyApp.navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(
                doctor: doctor,
                isFavorite: isFavorite,
              ),
            ),
          );
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.25,
                child: Image.network(
                  'http://127.0.0.1:8000${doctor['doctor_profile']}',
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['doctor_name'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        doctor['category'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const Spacer(flex: 1),
                          Text(
                            '${doctor['average_ratings'].toStringAsFixed(1)}',
                          ),
                          const Spacer(flex: 1),
                          const Text('Reviews'),
                          const Spacer(flex: 1),
                          Text('(${doctor['reviews'].length})'),
                          const Spacer(flex: 7),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
