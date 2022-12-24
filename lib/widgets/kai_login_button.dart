import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KaiLoginButton extends StatelessWidget {
  const KaiLoginButton({
    Key? key,
    required this.onClick,
    required this.bgColor,
    required this.asset,
  }) : super(key: key);

  final VoidCallback onClick;
  final Color bgColor;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onClick,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SvgPicture.asset(
            asset,
            height: 5,
            width: 5,
            fit: BoxFit.scaleDown,
          ),
        ));
  }
}
