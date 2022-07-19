import 'package:flutter/material.dart';

class EventsOption extends StatefulWidget {
  const EventsOption({Key? key}) : super(key: key);

  @override
  State<EventsOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<EventsOption> {
  final optionMap = <String, bool>{
    'Todos': true,
    'Últimos': false,
    'Favoritos': false,
  };
  @override
  Widget build(BuildContext context) {
    var key = optionMap.keys.toList();
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    var res = optionMap[key[index]];
                    optionMap[key[index]] = !res!;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: optionMap[key[index]] == true
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        key[index],
                        style: TextStyle(
                            fontSize: 13,
                            color: optionMap[key[index]] == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      if (optionMap[key[index]] == true)
                        Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.close,
                              size: 15,
                              color: Colors.white,
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
          separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
          itemCount: optionMap.length),
    );
  }
}
