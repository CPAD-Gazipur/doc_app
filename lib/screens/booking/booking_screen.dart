import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _day = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool? _isWeekend = false;
  bool? _dateSelected = false;
  bool? _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container();
  }
}
