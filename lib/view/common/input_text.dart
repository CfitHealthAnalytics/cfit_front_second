import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.label,
    this.inputFormatter,
    this.validator,
    this.controller,
    this.initialValue,
  }) : super(key: key);

  final String hintText;
  final String? initialValue;
  final String? label;
  final ValueChanged<String> onChanged;
  final InputTextType type;
  final GlobalKey<FormState>? formKey;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

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
        return Form(
          key: _formKey,
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: widget.label != null
                  ? Text(
                      widget.label!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  : null,
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            validator: widget.validator,
            inputFormatters: widget.inputFormatter,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            cursorColor: Colors.grey,
          ),
        );

      case InputTextType.email:
        return Form(
          key: _formKey,
          child: TextFormField(
            initialValue: widget.initialValue,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: widget.label != null
                  ? Text(
                      widget.label!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  : null,
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
            Form(
              key: _formKey,
              child: TextFormField(
                controller: widget.controller,
                focusNode: _focusNode,
                initialValue: widget.initialValue,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: widget.label != null
                      ? Text(
                          widget.label!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      : null,
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
                onChanged: widget.onChanged,
                obscureText: hiddenText,
                cursorColor: Colors.grey,
                validator: widget.validator,
              ),
            ),
            Positioned(
              right: 0,
              top: 12,
              child: GestureDetector(
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
              ),
            )
          ],
        );
      case InputTextType.textArea:
        return Form(
          key: _formKey,
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: widget.label != null
                  ? Text(
                      widget.label!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  : null,
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            validator: widget.validator,
            inputFormatters: widget.inputFormatter,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            cursorColor: Colors.grey,
            minLines: 4,
            maxLines: 5,
          ),
        );
      case InputTextType.number:
        return Form(
          key: _formKey,
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: widget.label != null
                  ? Text(
                      widget.label!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  : null,
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            validator: widget.validator,
            inputFormatters: widget.inputFormatter,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.number,
          ),
        );
      case InputTextType.date:
        return Form(
          key: _formKey,
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: widget.label != null
                  ? Text(
                      widget.label!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  : null,
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            validator: widget.validator,
            inputFormatters: widget.inputFormatter,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.datetime,
          ),
        );
    }
  }
}

enum InputTextType { email, text, password, textArea, number, date }
