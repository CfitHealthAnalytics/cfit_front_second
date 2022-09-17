import 'package:flutter/material.dart';

class ButtonAction extends StatefulWidget {
  const ButtonAction({
    Key? key,
    this.text,
    required this.type,
    this.onPressed,
    this.loading,
    this.customBackgroundColor,
    this.customIconColor,
    this.width,
    this.icon,
    this.height,
    this.textStyle,
  }) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final bool? loading;
  final ButtonActionType type;
  final Color? customBackgroundColor;
  final Color? customIconColor;
  final IconData? icon;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  @override
  State<ButtonAction> createState() => _ButtonActionState();
}

class _ButtonActionState extends State<ButtonAction> {
  bool hiddenText = true;

  Color _getColor() {
    if (widget.customBackgroundColor != null) {
      return widget.customBackgroundColor!;
    }

    return widget.onPressed == null
        ? const Color.fromARGB(100, 23, 97, 91)
        : const Color.fromARGB(255, 23, 97, 91);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case ButtonActionType.primary:
        return TextButton(
          child: Container(
            width: widget.width ?? double.maxFinite,
            height: widget.height,
            decoration: BoxDecoration(
              color: _getColor(),
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
                        widget.text!,
                        style: widget.textStyle ??
                            TextStyle(
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
            widget.text!,
            style: widget.textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          onPressed: widget.onPressed,
        );

      case ButtonActionType.chip:
        return InputChip(
          label: Text(
            widget.text!,
            style: widget.textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          backgroundColor: widget.onPressed == null
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColor,
          onPressed: widget.onPressed,
        );

      case ButtonActionType.icon:
        return IconButton(
          icon: CircleAvatar(
            backgroundColor:
                widget.customBackgroundColor ?? Theme.of(context).primaryColor,
            child: Icon(
              widget.icon!,
              color: widget.customIconColor ?? Colors.white,
            ),
          ),
          padding: const EdgeInsets.all(0),
          onPressed: widget.onPressed,
        );
    }
  }
}

enum ButtonActionType { primary, text, chip, icon }
