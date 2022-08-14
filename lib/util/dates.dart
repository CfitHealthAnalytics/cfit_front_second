const monthByInt = {
  1: 'Janeiro',
  2: 'Fevereiro',
  3: 'Março',
  4: 'Abril',
  5: 'Maio',
  6: 'Junho',
  7: 'Julho',
  8: 'Agosto',
  9: 'Setembro',
  10: 'Outubro',
  11: 'Novembro',
  12: 'Dezembro',
};

const dayByInt = {
  1: 'Segunda',
  2: 'Terça',
  3: 'Quarta',
  4: 'Quinta',
  5: 'Sexta',
  6: 'Sábado',
  7: 'Domingo',
};

String getMonthByInt(
  int code, {
  bool abbreviation = false,
}) =>
    abbreviation ? monthByInt[code]!.abbreviation() : monthByInt[code]!;

String getDayByInt(
  int code, {
  bool abbreviation = false,
}) =>
    abbreviation ? dayByInt[code]!.abbreviation() : dayByInt[code]!;

List<DateTime> buildArrayDate(
  DateTime initialDate, [
  int count = 6,
]) {
  final referenceDate = DateTime(
    initialDate.year,
    initialDate.month,
    initialDate.day,
  );
  final arrayDates = <DateTime>[];
  for (int iterator = 0; iterator < 6; iterator++) {
    if (iterator == 0) {
      arrayDates.add(initialDate);
    } else {
      arrayDates.add(referenceDate.add(Duration(days: iterator)));
    }
  }
  return arrayDates;
}

extension on String {
  String abbreviation() {
    return substring(0, 3);
  }
}
