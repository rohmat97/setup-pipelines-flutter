import 'package:flutter/material.dart';

class TourismTransparentButton extends StatelessWidget {
  const TourismTransparentButton({
    Key? key,
    required this.text,
    required this.onClick,
    required this.buttonColor,
    required this.textColor,
    required this.sideColor,
    this.width,
    this.padding = const EdgeInsets.only(left: 18.0, right: 18.0),
  }) : super(key: key);

  final String text;
  final VoidCallback onClick;
  final Color buttonColor;
  final Color textColor;
  final Color sideColor;
  final double? width;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: textColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(MediaQuery.of(context).size.width, 40),
            side: BorderSide(color: sideColor),
          ),
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(text), const Text('')],
          ),
        ),
      ),
    );
  }
}
