import 'package:flutter/material.dart';

class BottomWarning extends StatelessWidget {
  const BottomWarning({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 50,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
