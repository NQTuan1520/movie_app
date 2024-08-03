import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final bool isObscure;
  final FocusNode focusNode;
  final String validator;
  final Color color;
  final String hint;
  final bool isShowEyes;
  final Icon icon;
  const TextFormFieldCustom(
      {super.key,
      required this.controller,
      required this.isObscure,
      required this.focusNode,
      required this.validator,
      required this.color,
      required this.hint,
      required this.isShowEyes,
      required this.icon});

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      keyboardAppearance: Brightness.light,
      focusNode: widget.focusNode,
      onFieldSubmitted: (value) {
        widget.focusNode.unfocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validator;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widget.color, // Custom border color
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widget.color, // Custom border color when enabled
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widget.color, // Custom border color when focused
            width: 2.0,
          ),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: widget.color, fontSize: 14, fontWeight: FontWeight.w400),
        prefixIcon: widget.icon,
        suffixIcon: widget.isShowEyes
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;

                  });
                },
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              )
            : const SizedBox(
                width: 0,
                height: 0,
              ),
      ),
    );
  }
}
