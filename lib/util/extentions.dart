extension UpperLetter on String {
  String upperOnlyFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
