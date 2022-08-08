import 'package:flutter/material.dart';

const String pattern =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";

class InputText extends StatefulWidget {
  const InputText({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.type,
    this.formKey,
  }) : super(key: key);

  final String hintText;
  final ValueChanged<String> onChanged;
  final InputTextType type;
  final GlobalKey<FormState>? formKey;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool hiddenText = true;
  late final FocusNode _focusNode;
  late final GlobalKey<FormState> _formKey;
  bool focused = false;

  @override
  void initState() {
    _formKey = widget.formKey ?? GlobalKey<FormState>();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && focused) {
        _formKey.currentState?.validate();
      }

      if (_focusNode.hasFocus) {
        setState(() {
          focused = true;
        });
      } else {
        setState(() {
          focused = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          cursorColor: Colors.grey,
        );

      case InputTextType.email:
        return Form(
          key: _formKey,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            validator: (email) {
              RegExp regex = RegExp(pattern);
              if (email == null || email.isEmpty || !regex.hasMatch(email)) {
                return 'Insira um email válido';
              } else {
                return null;
              }
            },
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            cursorColor: Colors.grey,
          ),
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
                  borderRadius: BorderRadius.all(Radius.circular(12)),
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
