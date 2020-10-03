part of '../calendar_week.dart';

/// [findCurrentWeekIndexByDate] return -1 when cannot match
int findCurrentWeekIndexByDate(DateTime dateTime, List<_WeekItem> weeks) {
  for (int i = 0; i < weeks.length; i++) {
    final _WeekItem weeksItem = weeks[i];
    for (int j = 0; j < weeksItem.days.length; j++) {
      if (weeksItem.monthIndex == dateTime.month && _compareDate(dateTime, weeksItem.days[j])) {
        return i;
      }
    }
  }

  return -1;
}
