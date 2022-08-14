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
}
