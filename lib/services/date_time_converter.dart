import 'package:intl/intl.dart';

class DateTimeConverter {
  static String getDate({required DateTime dateTime}) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  static String getDay({required int day}) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }

  static String getTime({required int index}) {
    switch (index) {
      case 0:
        return '09:00 AM';
      case 1:
        return '10:00 AM';
      case 2:
        return '11:00 AM';
      case 3:
        return '12:00 AM';
      case 4:
        return '01:00 PM';
      case 5:
        return '02:00 PM';
      case 6:
        return '03:00 PM';
      case 7:
        return '04:00 PM';
      default:
        return '09:00 AM';
    }
  }
}
