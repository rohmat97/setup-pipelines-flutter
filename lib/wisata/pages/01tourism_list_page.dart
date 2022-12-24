import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/wisata/providers/tourism_list_state.dart';
import 'package:kai_wisata/wisata/widgets/tourism_card.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TourismListPage extends StatefulWidget {
  static const routeName = '/tourism-list-pages';

  const TourismListPage({Key? key}) : super(key: key);

  @override
  State<TourismListPage> createState() => _TourismListPageState();
}

class _TourismListPageState extends State<TourismListPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TourismListState state = TourismListState();

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
    state = Provider.of<TourismListState>(context);
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
                        'Wisata',
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TourismCard(onTap: () => state.onWagonSelected()),
                        const TourismCard(),
                        const TourismCard(),
                        const TourismCard(),
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
