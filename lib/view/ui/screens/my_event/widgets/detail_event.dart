import 'package:cfit/domain/models/events_city.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.eventCity,
  }) : super(key: key);

  final EventCity eventCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            eventCity.type.upperOnlyFirstLetter(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ).withPaddingOnly(bottom: 16),
          Text(
            eventCity.description.upperOnlyFirstLetter(),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ).withPaddingOnly(bottom: 16),
          CharacteristicEvent(
            label: 'Categoria',
            value: eventCity.type.upperOnlyFirstLetter(),
          ),
          CharacteristicEvent(
            label: 'Local',
            value:
                '''${eventCity.street.upperOnlyFirstLetter()} ${eventCity.number}, ${eventCity.neighborhood}, ${eventCity.city}''',
          ),
          CharacteristicEvent(
            label: 'Data / hora',
            value: eventCity.startTime.formatDateHour(),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CountConfirmed(eventCity: eventCity),
              ChipCFit(
                label: 'Editar',
                isSelected: true,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CharacteristicEvent extends StatelessWidget {
  const CharacteristicEvent({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          children: [
            TextSpan(
                text: value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ))
          ]),
    ).withPaddingSymmetric(vertical: 4);
  }
}

class ChipCFit extends StatelessWidget {
  const ChipCFit({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColorDark,
      onPressed: onPressed,
    );
  }
}

class CountConfirmed extends StatelessWidget {
  const CountConfirmed({
    Key? key,
    required this.eventCity,
  }) : super(key: key);

  final EventCity eventCity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
            text: eventCity.usersConfirmation.length.toString(),
            style: const TextStyle(color: Colors.black),
            children: [
              const TextSpan(text: '/'),
              TextSpan(
                text: eventCity.countMaxUsers.toString(),
              ),
            ],
          ),
        )
      ],
    ).withPaddingSymmetric(vertical: 4);
  }
}
