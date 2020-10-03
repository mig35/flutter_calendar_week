part of '../calendar_week.dart';

class _WeekItem {
  final int monthIndex;
  final String monthName;
  final List<String> dayOfWeek;
  final List<DateTime> days;

  _WeekItem({
    @required this.monthIndex,
    @required this.monthName,
    @required this.dayOfWeek,
    @required this.days,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WeekItem &&
          runtimeType == other.runtimeType &&
          monthIndex == other.monthIndex &&
          monthName == other.monthName &&
          dayOfWeek == other.dayOfWeek &&
          days == other.days;

  @override
  int get hashCode => monthIndex.hashCode ^ monthName.hashCode ^ dayOfWeek.hashCode ^ days.hashCode;
}
