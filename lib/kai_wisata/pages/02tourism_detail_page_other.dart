import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_button.dart';

class DetailOtherPage extends StatefulWidget {
  static const routeName = '/tourism-detail-pages-other';

  const DetailOtherPage({Key? key}) : super(key: key);

  @override
  State<DetailOtherPage> createState() => _DetailOtherPageState();
}

class _DetailOtherPageState extends State<DetailOtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: KaiColor.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                          20.0,
                        ),
                        child: InkWell(
                          child: SvgPicture.asset(
                            'assets/svg/arrow_left.svg',
                            height: 18,
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Konfirmasi Pemesanan',
                            style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.black),
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.only(top: 4.0),
                          //   child: Text(
                          //     '07 Des 2022',
                          //     textAlign: TextAlign.left,
                          //     style: TextStyle(fontSize: 10.0),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KaiColor.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                  child: Text(
                                    'Detail Pemesanan',
                                    style: KaiTextStyle.bodyLargeBold.apply(
                                      color: KaiColor.black,
                                      fontSizeDelta: 3.0,
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                const SizedBox(height: 20,),
                                Align(
                                  child: Text(
                                    'Kereta Wisata Bali',
                                    style: KaiTextStyle.bodyLargeBold.apply(
                                      color: KaiColor.black,
                                      fontSizeDelta: 8.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: Alignment.center,
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Gambir',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: KaiColor.black
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Pasar Turi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: KaiColor.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '08.55',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: KaiColor.black
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '19.35',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: KaiColor.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '11 Nov 2022',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: KaiColor.black
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '11 Nov 2022',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: KaiColor.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 18, right: 18),
                  width: MediaQuery.of(context).size.width,
                  child: KaiButton(
                    text: 'Konfirmasi Pemesanan',
                    onClick: () => {},
                    buttonColor: KaiColor.blue,
                    textColor: KaiColor.white,
                    sideColor: KaiColor.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}