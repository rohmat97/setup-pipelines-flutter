import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../helpers/theme.dart';

class PickDate extends StatelessWidget {
  PickDate(this.onPick, {Key? key}) : super(key: key);
  Function(DateTime) onPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: KaiColor.blue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    alignment: Alignment.center,
                    child: Text(
                      'Select Date',
                      style: KaiTextStyle.titleSmallBold.apply(
                        color: KaiColor.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: KaiColor.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              )
            ],
          ),
        ),
        SfDateRangePicker(
          allowViewNavigation: false,
          minDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            01,
          ),
          maxDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            31,
          ),
        ),
      ],
    );
  }

}