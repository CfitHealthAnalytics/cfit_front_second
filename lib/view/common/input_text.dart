import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.type,
  }) : super(key: key);

  final String hintText;
  final ValueChanged<String> onChanged;
  final InputTextType type;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool hiddenText = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case InputTextType.text:
        return TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
          onChanged: widget.onChanged,
          cursorColor: Colors.grey,
        );

      case InputTextType.email:
        return TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
          onChanged: widget.onChanged,
          cursorColor: Colors.grey,
        );

      case InputTextType.password:
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: widget.hintText,
                fillColor: Colors.white,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
              ),
              onChanged: widget.onChanged,
              obscureText: hiddenText,
              cursorColor: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  hiddenText = !hiddenText;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  hiddenText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        );
    }
  }
}

enum InputTextType { email, text, password }
