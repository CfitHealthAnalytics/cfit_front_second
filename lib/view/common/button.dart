import 'package:flutter/material.dart';

class ButtonAction extends StatefulWidget {
  const ButtonAction({
    Key? key,
    required this.text,
    required this.type,
    this.onPressed,
    this.loading,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool? loading;
  final ButtonActionType type;

  @override
  State<ButtonAction> createState() => _ButtonActionState();
}

class _ButtonActionState extends State<ButtonAction> {
  bool hiddenText = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case ButtonActionType.primary:
        return TextButton(
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: widget.onPressed == null
                  ? const Color.fromARGB(100, 23, 97, 91)
                  : const Color.fromARGB(255, 23, 97, 91),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: widget.loading == true
                    ? const SizedBox(
                        height: 19,
                        width: 19,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.text,
                        style: TextStyle(
                          color: widget.onPressed == null
                              ? Colors.white.withAlpha(100)
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
          onPressed: widget.onPressed,
        );

      case ButtonActionType.text:
        return TextButton(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: widget.onPressed,
        );
    }
  }
}

enum ButtonActionType { primary, text }
