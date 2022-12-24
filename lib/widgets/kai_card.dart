import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiCard extends StatelessWidget {
  const KaiCard({
    Key? key,
    required this.onClick,
    required this.bgColor,
    required this.text,
    required this.asset,
    required this.style,
  }) : super(key: key);

  final VoidCallback onClick;
  final Color bgColor;
  final String text;
  final String asset;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Card(
          color: bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: SvgPicture.asset(asset),
                    ),
                    Text(
                      text,
                      style: style,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.chevron_right,
                  color: KaiColor.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
