import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../helpers/theme.dart';

class KaiLoadingIndicator extends StatelessWidget {
  const KaiLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [KaiColor.primary],
            strokeWidth: 2,
            backgroundColor: KaiColor.white,
            pathBackgroundColor: KaiColor.neutral11
        )
    );
  }
}