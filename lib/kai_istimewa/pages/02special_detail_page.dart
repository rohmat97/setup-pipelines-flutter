import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_istimewa/arguments/special_arguments.dart';
import 'package:kai_wisata/kai_istimewa/providers/special_detail_state.dart';
import 'package:kai_wisata/kai_istimewa/services/special_services.dart';
import 'package:kai_wisata/kai_istimewa/widgets/special_detail_card.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_text_field.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_transparent_button.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_transparent_button.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SpecialDetailPage extends StatefulWidget {
  static const routeName = '/special-detail-pages';

  const SpecialDetailPage({Key? key}) : super(key: key);

  @override
  State<SpecialDetailPage> createState() => _SpecialDetailPageState();
}

class _SpecialDetailPageState extends State<SpecialDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SpecialDetailState state = SpecialDetailState();
  TextEditingController noteController = TextEditingController();
  TextEditingController penumpangController = TextEditingController();

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

    final args =
    ModalRoute.of(context)!.settings.arguments as SpecialArguments;

    state = Provider.of<SpecialDetailState>(context);
    state.initState(context, scaffoldKey, args);
    state.getDetail();

    if(!state.isLoaded) {
      noteController.text = args.info.note;
      penumpangController.text = args.info.penumpang.toString();
    }

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
                        'Lengkapi Data',
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
                          ),
                          child: Text(
                            'Detail Kereta',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        SpecialDetailCard(args: args, capacity: state.description,),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Data Pemesan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        KaiTransparentButton(
                          text: "${state.args?.info?.name}",
                          onClick: () => state.onCustomerSelected(
                            int.parse(penumpangController.text),
                            noteController.text
                          ),
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
                            'Jumlah Penumpang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismNumberField(
                          textController: penumpangController,
                          hint: '${state.capacity}',
                          obscure: false,
                          widget: const Text(''),
                          color: KaiColor.neutral11,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            'Catatan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        TourismTextField(
                          textController: noteController,
                          hint: 'Jika ada tambahan silahkan isi disini',
                          obscure: false,
                          widget: const Text(''),
                          color: KaiColor.neutral11,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 18.0,
                          ),
                          child: Text(
                            'Kisaran Harga',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: KaiColor.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            bottom: 9.0,
                          ),
                          child: Text(
                            "Rp ${NumberFormat.decimalPattern("Id").format(state.description?.kisaranBiaya)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: KaiColor.yellow,
                            ),
                          ),
                        ),
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
                                          value: state.isAgree,
                                          onChanged: (value) => state.setAgree(
                                              value!,
                                            int.parse(penumpangController.text),
                                            noteController.text
                                          )
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
                        state.isAgree? KaiButton(
                          text: 'Submit',
                          onClick: () async {
                            await state.onFinishButton(
                                int.parse(penumpangController.text),
                                noteController.text
                            );
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) =>
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0),
                                      ),
                                      color: KaiColor.white,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/svg/bar_line.svg',
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.2,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(18.0),
                                              child: Text(
                                                'Terima kasih untuk pemesanan kereta wisata, kami akan menghubungi anda segera setelah melakukan verifikasi data pemesanan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            KaiButton(
                                              text: 'Kembali',
                                              onClick: () =>
                                                  state.onFinishButton(
                                                      int.parse(
                                                          penumpangController
                                                              .text),
                                                      noteController.text
                                                  ),
                                              buttonColor: KaiColor.blue,
                                              textColor: KaiColor.white,
                                              sideColor: KaiColor.blue,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                          buttonColor: KaiColor.blue,
                          textColor: KaiColor.white,
                          sideColor: KaiColor.blue,
                        ):const SizedBox(height: 30,),
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
