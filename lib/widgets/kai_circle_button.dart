import 'package:flutter/material.dart';

class KaiCircleButton extends StatelessWidget {
  const KaiCircleButton({
    Key? key,
    required this.onClick,
    required this.bgColor,
    required this.asset,
  }) : super(key: key);

  final VoidCallback onClick;
  final Color bgColor;
  final Widget asset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: CircleAvatar(
        backgroundColor: bgColor,
        child: asset,
      ),
    );
  }
}
