import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiTextField extends StatelessWidget {
  const KaiTextField({
    Key? key,
    required this.textController,
    required this.hint,
    required this.obscure,
    required this.widget,
    required this.color,
    this.validator,
    this.keyboardType,
    // this.onChange,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final Widget widget;
  final Color color;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  // final String? Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: TextFormField(
        validator: validator,
        obscureText: obscure,
        controller: textController,
        keyboardType: keyboardType,
        // onChanged: onChange,
        decoration: InputDecoration(
          fillColor: color,
          filled: true,
          suffixIcon: widget,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: KaiColor.blue),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
