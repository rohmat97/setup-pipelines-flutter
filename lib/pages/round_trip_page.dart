import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/providers/search_result_state.dart';
import 'package:kai_wisata/widgets/kai_chosen_ticket_card.dart';
import 'package:kai_wisata/kai_reguler/widgets/kai_new_result_card.dart';
import 'package:provider/provider.dart';

import '../providers/round_trip_state.dart';

class RoundTripPage extends StatefulWidget {
  static const routeName = '/round-trip-pages';

  const RoundTripPage({Key? key}) : super(key: key);

  @override
  State<RoundTripPage> createState() => _RoundTripPageState();
}

enum Urutan { murah, awal, akhir }

class _RoundTripPageState extends State<RoundTripPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  RoundTripState state = RoundTripState();

  late Urutan _urut = Urutan.murah;

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<RoundTripState>(context);
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gambir - Semarang Tawang',
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '15 Mar 2022 | 1 Penumpang',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                KaiChosenTicketCard(
                  onTap: () {
                    state.onBackButton();
                  },
                ),
                Container(
                  color: KaiColor.blue,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Pilih kereta pulang ',
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
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        KaiNewResultCard(
                          onTap: () => state.onTicketSelected(),
                        ),
                        KaiNewResultCard(
                          onTap: () {},
                        ),
                        KaiNewResultCard(
                          onTap: () {},
                        ),
                        KaiNewResultCard(
                          onTap: () {},
                        ),
                        KaiNewResultCard(
                          onTap: () {},
                        ),
                      ],
                    ),
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
                                        value: Urutan.murah,
                                        groupValue: _urut,
                                        onChanged: (Urutan? value) {
                                          setState(() {
                                            _urut = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Berangkat Paling Awal',
                                      ),
                                      leading: Radio(
                                        value: Urutan.awal,
                                        groupValue: _urut,
                                        onChanged: (Urutan? value) {
                                          setState(() {
                                            _urut = value!;
                                          });
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
                                          value: Urutan.akhir,
                                          groupValue: _urut,
                                          onChanged: (Urutan? value) {
                                            setState(() {
                                              _urut = value!;
                                            });
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
