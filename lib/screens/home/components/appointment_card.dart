import 'package:doc_app/components/components.dart';
import 'package:doc_app/main.dart';
import 'package:doc_app/providers/dio_provider.dart';
import 'package:doc_app/services/services.dart';
import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class AppointmentCard extends StatefulWidget {
  final Map<String, dynamic> doctor;
  final Color color;

  const AppointmentCard({
    Key? key,
    required this.doctor,
    required this.color,
  }) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://127.0.0.1:8000${widget.doctor['doctor_profile'].toString()}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor['doctor_name'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.doctor['category'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              ScheduleCard(
                date: widget.doctor['appointments']['date'].toString(),
                day: widget.doctor['appointments']['day'].toString(),
                time: widget.doctor['appointments']['time'].toString(),
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => RatingDialog(
                            title: const Text(
                              'Rate the doctor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            message: const Text(
                              'Please give doctor review for better services',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            image: const FlutterLogo(
                              size: 30,
                            ),
                            initialRating: 5.0,
                            commentHint: 'Write your feedback about doctor...',
                            submitButtonText: 'Submit',
                            onSubmitted: (response) async {
                              String token =
                                  await SharedPreferencesService.getToken() ??
                                      '';

                              if (token != '') {
                                final result = await DioProvider()
                                    .storeReviewAndCompleteAppointment(
                                  token: token,
                                  appointmentID: widget.doctor['appointments']
                                      ['id'],
                                  doctorID: widget.doctor['doc_id'],
                                  ratings: response.rating.toDouble(),
                                  reviews: response.comment.toString() ?? '',
                                );

                                if (result) {
                                  MyApp.navigatorKey.currentState!
                                      .pushNamedAndRemoveUntil(
                                    '/main',
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              }
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
