import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/providers/regular_ticket_state.dart';
import 'package:kai_wisata/kai_reguler/providers/station_state.dart';
import 'package:kai_wisata/kai_reguler/widgets/kai_new_result_card.dart';
import 'package:kai_wisata/widgets/kai_search_field.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';

class StationPage extends StatefulWidget {
  static const routeName = '/station-pages';

  const StationPage({Key? key}) : super(key: key);

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TextEditingController searchController = TextEditingController();

  Widget tileDivider({double width = 22}) {
    return VerticalDivider(
      width: width,
      thickness: .25,
      color: KaiColor.white,
    );
  }

  @override
  Widget build(BuildContext context) {

    context.read<RegularTicketState>().getFromStation();
    
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
                                //onTap: () => state.onBackButton(),
                              ),
                            ),
                            Text(
                              'Stasiun Kereta Api',
                              style: KaiTextStyle.titleSmallBold
                                  .apply(color: KaiColor.black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: KaiColor.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: KaiSearchField(
                            textController: searchController,
                            hint: 'Cari stasiun kereta',
                            obscure: false,
                            widget: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      Container(
                        color: KaiColor.blue,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Stasiun terdekat ',
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
                          child:  ListView.builder(
                                    itemCount: context.watch<RegularTicketState>().fromStations.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          context.watch<RegularTicketState>().fromStations[index].code,
                                          style: KaiTextStyle.bodyLargeBold,
                                        ),
                                        subtitle: Text(context.watch<RegularTicketState>().fromStations[index].name,
                                          style: KaiTextStyle.bodySmallMedium,
                                        ),
                                        tileColor: KaiColor.white,
                                      );
                                    })



                      )
                    ]
                ),
              ]
          ),
        )
    );
  }
}
