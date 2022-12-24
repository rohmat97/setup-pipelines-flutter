import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';
import 'package:kai_wisata/kai_reguler/providers/search_result_state.dart';
import 'package:kai_wisata/kai_reguler/widgets/kai_new_result_card.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../models/rail_schedule.dart';

class SearchResultPage extends StatefulWidget {
  static const routeName = '/search-result-pages';

  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SearchResultState state = SearchResultState();

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  buildScheduleCards(Iterable<RailSchedule> schedules) {
    return [
      const SizedBox(
        height: 10.0,
      ),
      ...schedules.map((e) =>
          KaiNewResultCard(schedule: e, onTap: () => state.onTicketSelected(e)))
    ];
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
        ModalRoute.of(context)!.settings.arguments as SearchTicketArguments;

    state = Provider.of<SearchResultState>(context);
    state.initState(context, scaffoldKey);
    state.searchTicketOnce(args);

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
                            state.getHeaderTitle(),
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              state.getHeaderDescription(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: state.isLoaded
                      ? (state.schedules.isNotEmpty ? true : false)
                      : false,
                  child: Container(
                    color: KaiColor.blue,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Pilih kereta pergi ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: KaiColor.white,
                          ),
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
                        children: state.isLoaded
                            ? (state.schedules.isNotEmpty
                                ? buildScheduleCards(state.schedules)
                                : buildEmptyResult())
                            : buildIndicator()),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: KaiColor.neutral11,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Container(
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Urut Berdasarkan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.close),
                                          )
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Termurah',
                                      ),
                                      leading: Radio(
                                        value: SortResult.cheapest,
                                        groupValue: state.sort,
                                        onChanged: (SortResult? value) {
                                          state.changeSort(value!);
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Berangkat Paling Awal',
                                      ),
                                      leading: Radio(
                                        value: SortResult.earliest,
                                        groupValue: state.sort,
                                        onChanged: (SortResult? value) {
                                          state.changeSort(value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20.0,
                                      ),
                                      child: ListTile(
                                        title: const Text(
                                          'Berangkat Paling Akhir',
                                        ),
                                        leading: Radio(
                                          value: SortResult.latest,
                                          groupValue: state.sort,
                                          onChanged: (SortResult? value) {
                                            state.changeSort(value!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/urut.svg',
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Urutkan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KaiColor.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/filter_new.svg',
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KaiColor.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/calendar.svg',
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Ubah Tanggal',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: KaiColor.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
