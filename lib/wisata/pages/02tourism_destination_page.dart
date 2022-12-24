import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_istimewa/widgets/special_detail_card.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_text_field.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_transparent_button.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_custom_button.dart';
import 'package:kai_wisata/widgets/kai_transparent_button.dart';
import 'package:kai_wisata/wisata/providers/tourism_destination_state.dart';
import 'package:kai_wisata/wisata/widgets/tourism_order_card.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class TourismDestinationPage extends StatefulWidget {
  static const routeName = '/tourism-destination-pages';

  const TourismDestinationPage({Key? key}) : super(key: key);

  @override
  State<TourismDestinationPage> createState() => _TourismDestinationPageState();
}

class _TourismDestinationPageState extends State<TourismDestinationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TourismDestinationState state = TourismDestinationState();
  TextEditingController noteController = TextEditingController();

  bool check1 = false;

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  buildIndicator() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(top: 10),
            child: const LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [KaiColor.primary],
              strokeWidth: 2,
              backgroundColor: KaiColor.neutral11,
              pathBackgroundColor: KaiColor.neutral11,
            ),
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<TourismDestinationState>(context);
    state.initState(context, scaffoldKey);

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
                          onTap: () => state.onBackButton(),
                        ),
                      ),
                      Text(
                        'Destinasi Wisata',
                        style: KaiTextStyle.titleSmallBold
                            .apply(color: KaiColor.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            'Pesanan Anda',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        const TourismOrderCard(),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Nama Pemesan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTransparentButton(
                          text: 'Mareto',
                          onClick: () {},
                          buttonColor: KaiColor.neutral11,
                          textColor: KaiColor.black,
                          sideColor: KaiColor.grey,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Harga',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTransparentButton(
                          text: '400.000',
                          onClick: () {},
                          buttonColor: KaiColor.neutral11,
                          textColor: KaiColor.black,
                          sideColor: KaiColor.grey,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Jumlah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100.0),
                          child: KaiTransparentButton(
                            text: '1 Orang',
                            onClick: () {
                              buildPassengerBottomSheet(context, state);
                            },
                            buttonColor: KaiColor.neutral11,
                            textColor: KaiColor.black,
                            sideColor: KaiColor.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Harga Total',
                                style: TextStyle(
                                  color: KaiColor.black,
                                ),
                              ),
                              Text(
                                'Rp 400.000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: KaiColor.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        KaiButton(
                          text: 'Checkout',
                          onClick: () => state.onCheckoutButton(),
                          buttonColor: KaiColor.blue,
                          textColor: KaiColor.white,
                          sideColor: KaiColor.blue,
                        ),
                      ],
                    ),
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

Future<dynamic> buildPassengerBottomSheet(
  BuildContext context,
  TourismDestinationState state,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (_context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 28),
              const Text(
                'Jumlah Orang',
                style: KaiTextStyle.titleSmallBold,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  NumberPicker(
                    value: state.ticketCount,
                    minValue: 0,
                    maxValue: 100,
                    itemHeight: 32,
                    itemWidth: MediaQuery.of(_context).size.width / 3,
                    textStyle:
                        KaiTextStyle.labelRegular.apply(color: KaiColor.blue),
                    selectedTextStyle: KaiTextStyle.labelRegular.apply(
                      color: KaiColor.blue,
                    ),
                    decoration: BoxDecoration(
                      color: KaiColor.grey.withOpacity(.15),
                    ),
                    onChanged: (value) {
                      setModalState(() {
                        state.setTicketCount(value);
                      });
                    },
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
                      Navigator.of(_context).pop();
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
                      Navigator.of(_context).pop();
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
        },
      );
    },
  );
}
