import 'package:intl/intl.dart';

abstract class Utils {

 static ({String date, String time}) datetime() {
    DateTime now = DateTime.now();

    String date = DateFormat('EEEE, MMMM d, y').format(now);
    String time = DateFormat('h:mm:ss a').format(now).toLowerCase();

    return (date: date, time: time);
  }
}
