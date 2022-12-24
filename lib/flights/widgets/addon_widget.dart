import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kai_wisata/flights/models/addon/flight_addon_model.dart';
import 'package:kai_wisata/helpers/theme.dart';

class AddOnWidget extends StatefulWidget {
  final FlightAddOnModel addon;
  const AddOnWidget(this.addon, {Key? key}) : super(key: key);

  @override
  State<AddOnWidget> createState() => _AddOnWidgetState();
}

class _AddOnWidgetState extends State<AddOnWidget> {
  String bagasi = "Ya";
  String paket = "Ya";

  @override
  Widget build(BuildContext context) {
    if (widget.addon.isEnableNoBaggage!) {
      setState(() {
        bagasi = "Ya";
      });
    } else {
      setState(() {
        bagasi = "Tidak";
      });
    }

    if (widget.addon.isBaggageBundling!) {
      setState(() {
        paket = "Ya";
      });
    } else {
      setState(() {
        paket = "Tidak";
      });
    }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tidak Termasuk Bagasi? $bagasi',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: KaiColor.black,
          ),
        ),
        Text(
          'Paket Bagasi? $paket',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: KaiColor.black,
          ),
        ),
      ],
    );
  }
}