import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:intl/intl.dart';

class KaiTextDatePicker extends StatelessWidget {
  KaiTextDatePicker({
    Key? key,
    required this.textController,
    required this.hint,
    required this.obscure,
    required this.widget,
    required this.color,
    this.validator,
    required this.readOnly,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final Widget widget;
  final Color color;
  final bool readOnly;
  final String? Function(String?)? validator;

  DateTime dates = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: TextFormField(
        readOnly: readOnly,
        validator: validator,
        obscureText: obscure,
        controller: textController,
        onChanged: (value) {},
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: dates,
            firstDate: DateTime(1927),
            lastDate: DateTime.now()
          );

          if (picked != null && picked != dates) {
            dates = picked;
            var toText = DateFormat("yyyy-MM-dd").format(dates).toString();
            textController.text = toText;
          }
        },
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
