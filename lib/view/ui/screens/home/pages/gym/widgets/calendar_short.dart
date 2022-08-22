import 'package:cfit/util/dates.dart';
import 'package:flutter/material.dart';

class CalendarShort extends StatefulWidget {
  const CalendarShort({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final ValueChanged<DateTime> onChange;
  @override
  State<CalendarShort> createState() => _CalendarShortState();
}

class _CalendarShortState extends State<CalendarShort> {
  late DateTime date;
  late DateTime selectedDate;
  late List<DateTime> arrayDate;
  @override
  void initState() {
    date = DateTime.now();
    selectedDate = date;
    arrayDate = buildArrayDate(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: getMonthByInt(date.month),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: date.year.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        date = date.subtract(const Duration(days: 7));
                        arrayDate = buildArrayDate(date);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        date = date.add(const Duration(days: 7));
                        arrayDate = buildArrayDate(date);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: arrayDate
                .map(
                  (dateItem) => Column(
                    children: [
                      Text(
                        getDayByInt(
                          dateItem.weekday,
                          abbreviation: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DateCalendarShort(
                        date: dateItem,
                        isCurrentDate: selectedDate == dateItem,
                        pastDate: dateItem.compareTo(DateTime.now()) < 0,
                        onChange: (datePressed) {
                          setState(() {
                            selectedDate = datePressed;
                          });
                          widget.onChange(datePressed);
                        },
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class DateCalendarShort extends StatelessWidget {
  const DateCalendarShort({
    Key? key,
    required this.date,
    required this.isCurrentDate,
    required this.pastDate,
    required this.onChange,
  }) : super(key: key);

  final DateTime date;
  final bool isCurrentDate;
  final bool pastDate;
  final ValueChanged<DateTime> onChange;

  Color getColorText() {
    if (isCurrentDate) {
      return Colors.white;
    }
    return pastDate ? Colors.grey : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(date),
      child: CircleAvatar(
        backgroundColor: pastDate ? Colors.grey : Colors.black,
        radius: 20,
        child: CircleAvatar(
          backgroundColor:
              isCurrentDate ? Theme.of(context).primaryColor : Colors.white,
          radius: isCurrentDate ? 20 : 19,
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: getColorText(),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
