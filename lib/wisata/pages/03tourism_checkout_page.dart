import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/wisata/providers/tourism_checkout_state.dart';
import 'package:kai_wisata/wisata/widgets/tourism_checkout_card.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TourismCheckoutPage extends StatefulWidget {
  static const routeName = '/tourism-checkout-pages';

  const TourismCheckoutPage({Key? key}) : super(key: key);

  @override
  State<TourismCheckoutPage> createState() => _TourismCheckoutPageState();
}

class _TourismCheckoutPageState extends State<TourismCheckoutPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TourismCheckoutState state = TourismCheckoutState();
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
    state = Provider.of<TourismCheckoutState>(context);
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
                        'Checkout',
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
                        const TourismCheckoutCard(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 5.0,
                            bottom: 18.0,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: KaiColor.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18.0,
                                    right: 18.0,
                                    top: 18.0,
                                    bottom: 9.0,
                                  ),
                                  child: RichText(
                                    text: const TextSpan(
                                      text:
                                          'Dengan ini saya setuju dan mematuhi syarat dan ketentuan pemesanan ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: KaiColor.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'PT Kereta Api Indonesia (Persero) ',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: KaiColor.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'termasuk pembayaran dan mematuhi semua peraturan dan batasan mengenai ketersediaan tarif atau layanan.',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: KaiColor.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 18.0,
                                    right: 18.0,
                                  ),
                                  child: Divider(
                                    color: KaiColor.black,
                                    thickness: 0.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18.0,
                                    right: 18.0,
                                    bottom: 18.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          checkColor: KaiColor.white,
                                          activeColor: KaiColor.blue,
                                          value: check1,
                                          onChanged: (value) {
                                            setState(() {
                                              check1 = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: RichText(
                                          text: const TextSpan(
                                            text:
                                                'Saya telah membaca dan setuju terhadap ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: KaiColor.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Syarat dan Ketentuan pembelian tiket',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: KaiColor.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                'Total Tagihan',
                                style: TextStyle(
                                  color: KaiColor.black,
                                ),
                              ),
                              Text(
                                'Rp 800.000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: KaiColor.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        KaiButton(
                          text: 'Pilih Metode Pembayaran',
                          onClick: () {},
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
