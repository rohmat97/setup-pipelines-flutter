import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiLastTransaction extends StatelessWidget {
  const KaiLastTransaction({
    Key? key,
    required this.onClick,
    required this.title,
    required this.subtitle,
    required this.status,
  }) : super(key: key);

  final VoidCallback onClick;
  final String title;
  final String subtitle;
  final String status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: KaiColor.neutral11,
        // child: ListTile(
        //   tileColor: KaiColor.neutral11,
        //   leading: SvgPicture.asset('assets/svg/ic_online.svg'),
        //   title: Text(
        //     title,
        //     style: KaiTextStyle.bodySmallBold,
        //   ),
        //   subtitle: Text(
        //     subtitle,
        //     style: KaiTextStyle.bodySmallBold,
        //   ),
        //   trailing: Text(
        //     status,
        //     style: KaiTextStyle.bodySmallBold.apply(
        //       color: KaiColor.green,
        //     ),
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      'assets/svg/ic_online.svg',
                      height: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: KaiTextStyle.bodySmallBold,
                      ),
                      Text(
                        subtitle,
                        style: KaiTextStyle.bodySmallBold
                            .apply(color: KaiColor.grey, fontSizeDelta: -2),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                status,
                style: KaiTextStyle.bodySmallBold
                    .apply(color: KaiColor.greenText, fontSizeDelta: -2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
