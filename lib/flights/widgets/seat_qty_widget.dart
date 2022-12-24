import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../helpers/theme.dart';
import '../../widgets/kai_custom_button.dart';

class SeatQty extends StatelessWidget {
  SeatQty(this.seat, this.onChange, {Key? key}) : super(key: key);
  
  int seat;
  Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 28),
        const Text(
          'Add Seat',
          style: KaiTextStyle.titleSmallBold,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: KaiColor.black,
                          width: .25,
                        ),
                      ),
                    ),
                    child: SizedBox(height: 1,)
                ),
                NumberPicker(
                  value: seat,
                  minValue: 1,
                  maxValue: 7,
                  itemHeight: 32,
                  itemWidth: MediaQuery.of(context).size.width,
                  textStyle: KaiTextStyle.labelRegular
                      .apply(color: KaiColor.blue),
                  selectedTextStyle: KaiTextStyle.labelRegular.apply(
                    color: KaiColor.blue,
                  ),
                  decoration: BoxDecoration(
                    color: KaiColor.grey.withOpacity(.15),
                  ),
                  onChanged: (value) => onChange(value),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            // const SizedBox(width: 18),
            KaiCustomButton(
              text: 'Cancel',
              onClick: () {
                Navigator.of(context).pop();
              },
              buttonColor: KaiColor.blue.withOpacity(0.1),
              textColor: KaiColor.blue,
              sideColor: KaiColor.blue.withOpacity(0.1),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 40,
            ),
            KaiCustomButton(
              text: 'Select',
              onClick: () {
                Navigator.of(context).pop();
              },
              buttonColor: KaiColor.blue,
              textColor: KaiColor.white,
              sideColor: KaiColor.blue,
              width: MediaQuery.of(context).size.width * 0.4,
              height: 40,
            ),
          ],
        ),
        const SizedBox(height: 48),
      ],
    );
  }

}