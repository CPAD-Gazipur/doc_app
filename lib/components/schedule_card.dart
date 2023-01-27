import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  const ScheduleCard({
    Key? key,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: textColor,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            'Monday - January 27, 2023',
            style: TextStyle(
              color: textColor,
            ),
          ),
          const SizedBox(width: 20),
          Icon(
            Icons.access_alarm,
            color: textColor,
            size: 17,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              '02:00 PM',
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
