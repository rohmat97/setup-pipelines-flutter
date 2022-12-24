import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiSearchField extends StatelessWidget {
  const KaiSearchField({
    Key? key,
    required this.textController,
    required this.hint,
    required this.obscure,
    required this.widget,
    this.validator,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final Widget widget;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: TextFormField(
        validator: validator,
        obscureText: obscure,
        controller: textController,
        onChanged: (value) {},
        decoration: InputDecoration(
          fillColor: KaiColor.neutral11,
          filled: true,
          prefixIcon: widget,
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
