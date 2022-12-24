import 'package:flutter/material.dart';

import '../commons.dart';
import 'container.dart';

class MenuBubble extends StatelessWidget {
  const MenuBubble({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    required this.width,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Function()? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return NewAvicennaContainer(
      onTap: onTap,
      color: Colors.transparent,
      // isTransparent: true,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
      width: width,
      child: IntrinsicHeight(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.35),
              child: Container(
                height: width * 0.7,
                width: width * 0.7,
                // color: MyColors.background1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.35),
                  border: Border.all(color: MyColors.background1, width: 2)
                ),
                child: Center(
                  child: icon
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ), textAlign: TextAlign.center)
          ],
        )
      )
    );
  }

}

