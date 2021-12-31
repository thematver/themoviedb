import 'package:themoviedb/view/view.dart';

class DateFormat {
  static String prettify(DateTime? time) {
    if (time == null) return "Неизвестно";
    int day = time.day;
    String month = Constants.monthsInGenative[time.month - 1];
    int year = time.year;

    return "$day $month $year";
  }
}
