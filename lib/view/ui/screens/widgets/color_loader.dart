import 'package:flutter/material.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  List<Color>? colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];
  Duration? duration = const Duration(milliseconds: 1200);

  @override
  _ColorLoaderState createState() => _ColorLoaderState(colors!, duration!);
}

class _ColorLoaderState extends State<Loading>
    with SingleTickerProviderStateMixin {
  final List<Color> colors;
  final Duration duration;
  late Timer timer;

  _ColorLoaderState(this.colors, this.duration);

  //noSuchMethod(Invocation i) => super.noSuchMethod(i);

  List<ColorTween> tweenAnimations = [];
  int tweenIndex = 0;

  late AnimationController controller;
  List<Animation<Color?>> colorAnimations = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    for (int i = 0; i < colors.length - 1; i++) {
      tweenAnimations.add(ColorTween(begin: colors[i], end: colors[i + 1]));
    }

    tweenAnimations
        .add(ColorTween(begin: colors[colors.length - 1], end: colors[0]));

    for (int i = 0; i < colors.length; i++) {
      Animation<Color?> animation = tweenAnimations[i].animate(CurvedAnimation(
          parent: controller,
          curve: Interval((1 / colors.length) * (i + 1) - 0.05,
              (1 / colors.length) * (i + 1),
              curve: Curves.linear)));

      colorAnimations.add(animation);
    }

    tweenIndex = 0;

    timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        tweenIndex = (tweenIndex + 1) % colors.length;
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          valueColor: colorAnimations[tweenIndex],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }
}
