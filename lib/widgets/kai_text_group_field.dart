import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiTextGroupField extends StatelessWidget {
  const KaiTextGroupField({
    Key? key,
    required this.textController,
    required this.hint,
    required this.obscure,
    required this.color,
    this.validator,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final Color color;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        validator: validator,
        obscureText: obscure,
        controller: textController,
        onChanged: (value) {},
        decoration: InputDecoration(
          fillColor: color,
          filled: true,
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
