import 'package:flutter/material.dart';

class KaiScrollableCard extends StatelessWidget {
  const KaiScrollableCard({
    Key? key,
    required this.text,
    required this.txtColor,
    required this.bgColor,
    required this.padding,
  }) : super(key: key);

  final String text;
  final Color txtColor;
  final Color bgColor;
  final double padding;

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
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: txtColor,
            ),
          ),
        ),
      ),
    );
  }
}
