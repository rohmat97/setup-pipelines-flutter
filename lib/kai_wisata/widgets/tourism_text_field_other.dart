import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

class TourismTextFieldOther extends StatelessWidget {
  const TourismTextFieldOther({
    Key? key,
    required this.textController,
    required this.hint,
    required this.obscure,
    required this.widget,
    required this.color,
    this.validator,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final Widget widget;
  final Color color;
  final String? Function(String?)? validator;
  final VoidCallback Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          validator: validator,
          obscureText: obscure,
          controller: textController,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            fillColor: color,
            filled: true,
            suffixIcon: widget,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(color: KaiColor.grey),
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
      ),
    );
  }
}