import 'package:doc_app/components/components.dart';
import 'package:doc_app/main.dart';
import 'package:doc_app/providers/dio_provider.dart';
import 'package:doc_app/services/services.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool _isWeekend = false;
  bool _dateSelected = true;
  bool _timeSelected = false;

  int? _currentIndex;

  String? token;

  DateTime _focusedDay = DateTime.now();
  DateTime _currentDay = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;

  Future<void> geToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });
  }

  @override
  void initState() {
    geToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    final doctor = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Appointment',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 10,
                  ),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 30,
                    ),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        'Weekend is not available, please select another date.',
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: _currentIndex == index
                                ? Config.primaryColor
                                : null,
                          ),
                          alignment: Alignment.center,
                          clipBehavior: Clip.antiAlias,
                          child: Text(
                            '${index + 9 > 12 ? ((index + 9) - 12) : index + 9}:00 ${index + 9 > 11 ? 'PM' : 'AM'}',
                            style: TextStyle(
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                  ),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 30,
              ),
              child: CustomButton(
                title: 'Make Appointment',
                width: double.infinity,
                onPressed: () async {
                  final bookingDate = DateTimeConverter.getDate(
                    dateTime: _currentDay,
                  );
                  final bookingDay = DateTimeConverter.getDay(
                    day: _currentDay.weekday,
                  );
                  final bookingTime = DateTimeConverter.getTime(
                    index: _currentIndex!,
                  );

                  bool appointmentBooked = await DioProvider().bookAppointment(
                    token: token!,
                    doctorID: doctor['doctor_id'],
                    date: bookingDate,
                    day: bookingDay,
                    time: bookingTime,
                  );

                  if (appointmentBooked) {
                    MyApp.navigatorKey.currentState!
                        .pushNamed('/success-screen');
                  } else {}
                },
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tableCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2023, 12, 31),
        calendarFormat: _calendarFormat,
        currentDay: _currentDay,
        rowHeight: 48,
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Config.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onDaySelected: ((selectedDay, focusDay) {
          setState(() {
            _currentDay = selectedDay;
            _focusedDay = focusDay;
            _dateSelected = true;

            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            } else {
              _isWeekend = false;
            }
          });
        }),
      ),
    );
  }
}
