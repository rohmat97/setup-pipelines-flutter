import 'package:flutter/material.dart';
import 'package:kai_wisata/data/models/ticket_class.dart';

import '../../helpers/theme.dart';
import '../../widgets/kai_button.dart';

class SeatClass extends StatefulWidget {

  SeatClass(this.initial, this.onSubmit, {Key? key}) : super(key: key);
  TicketClass initial;
  Function(TicketClass) onSubmit;

  @override
  State<StatefulWidget> createState() => _SeatClassState();
}

class _SeatClassState extends State<SeatClass> {
  TicketClass selected = TicketClass.economy;

  @override
  void initState() {
    super.initState();
    setState(() {
      selected = widget.initial;
    });
  }

  Widget buildSeatClassOption(TicketClass kelas) {
    var optionImage = kelas == selected ?
    const AssetImage('assets/images/selected_option.png') :
    const AssetImage('assets/images/unselected_option.png');

    var desc = TicketClassDescription.fromEnum(kelas);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child:
        InkWell(
          onTap: () =>
          setState(() {
            selected = kelas;
          }),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image(
                  image: optionImage,
                  height: 16,
                  width: 16,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      desc.title,
                      style: KaiTextStyle.labelRegular,
                    ),
                    Text(
                      desc.description,
                      style: KaiTextStyle.smallThin,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 28),
        const Text(
          'CHOOSE YOUR SEAT CLASS',
          style: KaiTextStyle.titleSmallBold,
        ),
        const SizedBox(height: 10),
        const Divider(
          height: 0,
          thickness: .25,
          color: KaiColor.black,
        ),
        const SizedBox(height: 20),
        buildSeatClassOption(TicketClass.economy),
        const SizedBox(height: 18),
        buildSeatClassOption(TicketClass.business),
        const SizedBox(height: 18),
        buildSeatClassOption(TicketClass.executive),
        const SizedBox(height: 20),
        KaiButton(
          text: 'Done',
          onClick: () {
            Navigator.of(context).pop();
            widget.onSubmit(selected);
          },
          buttonColor: KaiColor.blue,
          textColor: KaiColor.white,
          sideColor: KaiColor.blue,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}