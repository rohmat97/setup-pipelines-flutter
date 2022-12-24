import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_tipe.dart';
import 'package:kai_wisata/kai_wisata/providers/tourism_wagon_state.dart';
import 'package:kai_wisata/kai_wisata/widgets/tourism_wagon_card.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../arguments/tourism_search_arguments.dart';
import '../arguments/tourism_wagon_arguments.dart';

class TourismWagonPage extends StatefulWidget {
  static const routeName = '/tourism-wagon-pages';

  const TourismWagonPage({Key? key}) : super(key: key);

  @override
  State<TourismWagonPage> createState() => _TourismWagonPageState();
}

class _TourismWagonPageState extends State<TourismWagonPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TourismWagonState state = TourismWagonState();

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  buildEmptyResult() {
    return [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/not_found.png',
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Text(
            "Kereta Tidak Tersedia",
            style: KaiTextStyle.bodyLargeBold.apply(color: KaiColor.black),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Maaf, kereta yang sesuai dengan pencarian Anda tidak tersedia. Silakan pilih tanggal lain atau ubah pencarian Anda",
              textAlign: TextAlign.center,
              style: KaiTextStyle.bodyLargeMedium,
            ),
          ),
        ],
      )
    ];
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
    ModalRoute.of(context)!.settings.arguments as TourismWagonArguments;

    state = Provider.of<TourismWagonState>(context);
    state.initState(context, scaffoldKey, args);
    state.listWagon();

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${args.searchArguments.from?.name} - ${args.searchArguments.to?.name}",
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              args.searchArguments.shortFromDate,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: KaiColor.blue,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Pilih Gerbong ',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: KaiColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state.wagons.map((e) {
                        return TourismWagonCard(
                            onTap: () => state.onWagonSelected(e),
                            wagon: e);
                      }).toList()
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

buildWagonCards(List<TourismTipe> wagons) {

}
