import 'package:flutter/material.dart';

abstract class Modal extends StatelessWidget {
  final double fraction;
  
  const Modal({
    Key? key,
    this.fraction = 0.5,
  }) : super(key: key);
}
