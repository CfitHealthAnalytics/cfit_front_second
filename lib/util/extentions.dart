extension UpperLetter on String {
  String upperOnlyFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateShow on DateTime {
  String getCustomHour() {
    final _hours = toIso8601String().split(r'T')[1].split(r':');
    _hours.removeLast();
    return _hours.join(':');
  }

  String getCustomDate() {
    return toIso8601String()
        .split(r'T')[0]
        .substring(5)
        .split('-')
        .reversed
        .join('/');
  }

  String formatDateHour() {
    // 1969-07-20T20:18:04.000Z
    final textDate = toIso8601String();
    final date = textDate.split(r'T')[0].split(r'-').reversed.join('/');
    final hour = textDate.split(r'T')[1].split(r':').take(2).join(':');
    return '$date $hour';
  }
}
