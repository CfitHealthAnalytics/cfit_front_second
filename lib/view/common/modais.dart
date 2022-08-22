import 'package:flutter/material.dart';

abstract class Modal {
  final Widget title;
  final Widget? subtitle;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final double fraction;

  Modal({
    required this.title,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.fraction = 0.5,
  });
}
