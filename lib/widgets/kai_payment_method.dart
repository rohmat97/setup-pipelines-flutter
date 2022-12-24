import 'package:flutter/material.dart';
import 'package:kai_wisata/helpers/theme.dart';

class KaiPaymentMethod extends StatelessWidget {
  const KaiPaymentMethod({
    Key? key,
    required this.method,
  }) : super(key: key);

  final String method;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KaiColor.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                left: 18.0,
                right: 18.0,
                bottom: 14.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(method),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
