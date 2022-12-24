import 'dart:io';

import 'package:flutter/material.dart';

Future<dynamic> showLevelUpBottomSheet(BuildContext context,
    {required VoidCallback onButtonPressed}) async {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) => LevelUpDialog(
      onButtonPressed: onButtonPressed,
    ),
  );
}

class LevelUpDialog extends StatelessWidget {
  final VoidCallback? onButtonPressed;

  const LevelUpDialog({
    Key? key,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/newAsset/logoperpusblue.png',
            fit: BoxFit.contain,
            width: 227,
            height: 101,
          ),
          Image.asset(
            'assets/images/finish.png',
            width: 260,
            height: 212,
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: 'Selamat, \nkamu adalah',
                ),
                TextSpan(
                  text: ' Good Reader',
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: 'Pertahankan! Kamu telah membaca total',
                ),
                TextSpan(
                  text: ' 10 Buku',
                ),
                TextSpan(
                  text: ' dan menulis',
                ),
                TextSpan(
                  text: ' 8 Ulasan',
                ),
                TextSpan(
                  text: ' Lanjutkan perjalanan membaca kamu dan '
                      'mencapai level membaca teratas!',
                ),
              ],
            ),
          ),
          const SizedBox(height: 75),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
