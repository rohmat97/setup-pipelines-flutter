import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiPhoneNumber extends StatelessWidget {
  const KaiPhoneNumber({
    Key? key,
    required this.textController,
    required this.hint,
    required this.obscure,
    required this.widget,
    required this.color,
    this.validator,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final Widget widget;
  final Color color;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: TextFormField(
        validator: validator,
        obscureText: obscure,
        controller: textController,
        onChanged: (value) {},
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
