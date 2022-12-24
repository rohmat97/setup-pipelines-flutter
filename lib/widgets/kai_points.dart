import 'package:flutter/material.dart';

class KaiPoints extends StatelessWidget {
  const KaiPoints({
    Key? key,
    required this.text,
    required this.txtColor,
    required this.bgColor,
  }) : super(key: key);

  final String text;
  final Color txtColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: txtColor,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
    );
  }
}
