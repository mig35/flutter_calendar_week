part of '../calendar_week.dart';

class _WeekItem {
  final String month;
  final List<String> dayOfWeek;
  final List<DateTime> days;

  _WeekItem({
    this.month = '',
    this.dayOfWeek = const [],
    this.days = const []
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WeekItem &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          dayOfWeek == other.dayOfWeek &&
          days == other.days;

  @override
  int get hashCode => month.hashCode ^ dayOfWeek.hashCode ^ days.hashCode;
}
