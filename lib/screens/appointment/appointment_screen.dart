import 'dart:convert';

import 'package:doc_app/components/components.dart';
import 'package:doc_app/providers/dio_provider.dart';
import 'package:doc_app/services/services.dart';
import 'package:doc_app/utils/enum.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  FilterStatus status = FilterStatus.upcoming;

  Alignment _alignment = Alignment.centerLeft;

  List<dynamic> schedules = [];

  Future<void> getAppointments() async {
    final token = await SharedPreferencesService.getToken() ?? '';

    if (token != '') {
      final appointments = await DioProvider().getAppointments(token: token);

      if (appointments != 'Error') {
        setState(() {
          schedules = json.decode(appointments);
          debugPrint('Appointments: $schedules');
        });
      }
    }
  }

  @override
  void initState() {
    getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'upcoming':
          schedule['status'] = FilterStatus.upcoming;
          break;
        case 'complete':
          schedule['status'] = FilterStatus.complete;
          break;
        case 'cancel':
          schedule['status'] = FilterStatus.cancel;
          break;
      }
      return schedule['status'] == status;
    }).toList();

    Config().init(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// TITLE
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,

            /// STATUS TAB
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              /// UPCOMING
                              if (filterStatus == FilterStatus.upcoming) {
                                setState(() {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                });
                              }

                              /// COMPLETE
                              else if (filterStatus == FilterStatus.complete) {
                                setState(() {
                                  status = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                });
                              }

                              /// CANCEL
                              else if (filterStatus == FilterStatus.cancel) {
                                setState(() {
                                  status = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name.toUpperCase(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(
                    microseconds: 500,
                  ),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Config.spaceSmall,

            /// SCHEDULE LIST
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length - 1 == index;
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: status == FilterStatus.complete
                            ? Colors.green
                            : status == FilterStatus.cancel
                                ? Colors.red
                                : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: isLastElement
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// DOCTOR BASIC INFO
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'http://127.0.0.1:8000${schedule['doctor_profile']}',
                                ),
                                backgroundColor: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schedule['doctor_name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    schedule['category'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          /// SCHEDULE INFO
                          ScheduleCard(
                            backgroundColor: Colors.grey.shade200,
                            textColor: Config.primaryColor,
                            date: schedule['date'],
                            day: schedule['day'],
                            time: schedule['time'],
                          ),
                          const SizedBox(height: 15),

                          /// BUTTON
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Config.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Reschedule',
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
