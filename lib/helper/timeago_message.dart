import 'package:timeago/timeago.dart';

/// Eigene Bezeichnungen für timeago-Funktion
class MyCustomDEMessages implements LookupMessages {
  @override
  String prefixAgo() => 'Vor ';
  @override
  String prefixFromNow() => 'In ';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => '< 1 Minute';
  @override
  String aboutAMinute(int minutes) => '${minutes} Minute';
  @override
  String minutes(int minutes) => '${minutes} Minuten';
  @override
  String aboutAnHour(int minutes) => '${minutes} Minuten';
  @override
  String hours(int hours) => '${hours} Stunden';
  @override
  String aDay(int hours) => '${hours} Stunden';
  @override
  String days(int days) => '${days} Tage';
  @override
  String aboutAMonth(int days) => '${days} Tage';
  @override
  String months(int months) => '${months} Monate';
  @override
  String aboutAYear(int year) => '${year} Monate';
  @override
  String years(int years) => '${years} Jahr';
  @override
  String wordSeparator() => ' ';
}
