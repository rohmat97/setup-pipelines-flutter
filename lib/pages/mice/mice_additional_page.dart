import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/checkbox.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/text_field.dart';

class MiceAdditionalPage extends StatefulWidget {
  const MiceAdditionalPage({
    // required this.mice,
    Key? key
  }) : super(key: key);

  // final Mice mice;

  @override
  State<MiceAdditionalPage> createState() => _MiceAdditionalPageState();
}

class _MiceAdditionalPageState extends State<MiceAdditionalPage> {

  @override
  void initState() {
    super.initState();
    //
  }

  bool meja = false;
  bool mc = false;
  bool band = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Fasilitas Tambahan', style: TextStyle(
            color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            color: MyColors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                AvicennaContainer(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: meja,
                            onChanged: (val) {
                              setState(() {
                                meja = val!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Text('Meja Rapat', style: MyTextStyle.heading2),
                          const Spacer(),
                          Text('20.000 / set', style: TextStyle(
                            color: Colors.red
                          )),
                        ],
                      ),
                      Text('Meja Rapat termasuk dengan kursi'),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 72,
                        child: AvicennaTextField(
                          initialValue: '10',
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(thickness: 2, height: 38),
                AvicennaContainer(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: mc,
                            onChanged: (val) {
                              setState(() {
                                mc = val!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Text('MC', style: MyTextStyle.heading2),
                          const Spacer(),
                          Text('340.000 / 4 Jam', style: TextStyle(
                              color: Colors.red
                          )),
                        ],
                      ),
                      Text('MC dapat kegiatan pernikahan, acara resmi, maupun hiburan'),
                    ],
                  ),
                ),
                const Divider(thickness: 2, height: 38),
                AvicennaContainer(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: band,
                            onChanged: (val) {
                              setState(() {
                                band = val!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Text('Band Music', style: MyTextStyle.heading2),
                          const Spacer(),
                          Text('1.200.000 / Jam', style: TextStyle(
                              color: Colors.red
                          )),
                        ],
                      ),
                      Text('Band music lengkap dengan vocal, yang siap menghibur acara kamu'),
                    ],
                  ),
                ),
                const Divider(thickness: 2, height: 38),
                AvicennaButton(
                  text: 'Simpan',
                  onPressed: () {
                    Navigator.pop(context, [meja, mc, band]);
                  },
                )
              ]
            ),
          ),
        )
      )
    );
  }
}