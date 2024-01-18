import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.secureText,
    this.enable,
    this.keyboardType,
    this.maxLines = 1,
    this.onChange,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.autovalidateMode,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String hint;
  final bool? secureText;
  final bool? enable;
  final TextInputType? keyboardType;
  final int? maxLines;
  final void Function(String)? onChange;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      enabled: enable,
      onChanged: onChange,
      obscureText: secureText ?? false,
      cursorColor: Colors.black,
      decoration: textFieldDecoration(),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      filled: true,
      hintText: hint,
      contentPadding: const EdgeInsets.only(
        left: 15,
        top: 17,
        bottom: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: border(),
      enabledBorder: border(),
      errorBorder: errorBorder(),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }

  UnderlineInputBorder errorBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    );
  }
}
