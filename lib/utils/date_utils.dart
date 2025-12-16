class AppDateUtils {
  static String getWeekStr(DateTime date) {
    int currentWeek = _getWeekOfMonth(date);
    int totalWeeks = _getTotalWeeksInMonth(date);
    return 'Week $currentWeek/$totalWeeks';
  }

  static List<DateTime> getDaysInWeek(DateTime date) {
    int daysToSubtract = date.weekday - 1;
    DateTime startOfWeek = date.subtract(Duration(days: daysToSubtract));

    return List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  static int _getWeekOfMonth(DateTime date) {
    DateTime firstDay = DateTime(date.year, date.month, 1);

    int weekOfMonth = 1;
    DateTime tempDate = firstDay;
    while (tempDate.isBefore(date) || isSameDay(tempDate, date)) {
      if (tempDate.weekday == 7 && !isSameDay(tempDate, date)) {}
      if (tempDate.weekday == 1 && tempDate != firstDay) {
        weekOfMonth++;
      }

      tempDate = tempDate.add(const Duration(days: 1));
    }

    int dayOfYear = int.parse("${date.day}");
    int firstWeekday = firstDay.weekday;
    int weekIndex = ((date.day + firstWeekday - 2) / 7).floor() + 1;
    return weekIndex;
  }

  static int _getTotalWeeksInMonth(DateTime date) {
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);
    int firstWeekday = firstDay.weekday;
    int totalDays = lastDay.day;

    // Same formula as above for the last day
    int totalWeeks = ((totalDays + firstWeekday - 2) / 7).floor() + 1;
    return totalWeeks;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
