import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  final String date;
  final String day;
  final String time;

  const ScheduleCard({
    Key? key,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
    required this.date,
    required this.day,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                color: textColor,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                '$day - $date',
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.access_alarm,
                color: textColor,
                size: 17,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  time,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
