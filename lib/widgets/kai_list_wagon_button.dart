import 'package:flutter/material.dart';

class KaiListWagonButton extends StatelessWidget {
  const KaiListWagonButton({
    Key? key,
    required this.text,
    required this.onClick,
    required this.buttonColor,
    required this.textColor,
    required this.sideColor,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Text text;
  final VoidCallback onClick;
  final Color buttonColor;
  final Color textColor;
  final Color sideColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: textColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: Size(width, height),
          side: BorderSide(color: sideColor),
        ),
        onPressed: onClick,
        child: text,
      ),
    );
  }
}
