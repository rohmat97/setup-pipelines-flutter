import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kai_wisata/hotel/arguments/search_hotel_arguments.dart';
import 'package:kai_wisata/hotel/providers/hotel_search_state.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import '../models/city.dart';
import '02hotel_list_page.dart';

class HotelSearchPage extends StatefulWidget {
  static const routeName = '/hotel-search-pages';

  const HotelSearchPage({Key? key}) : super(key: key);

  @override
  State<HotelSearchPage> createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelSearchPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HotelSearchState state = HotelSearchState();

  String tujuan = '';

  DateTime dateIn = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateTime.now())).add(
      const Duration(days: 1));
  DateTime dateOut = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateTime.now())).add(
      const Duration(days: 2));

  @override
  void initState() {
    super.initState();
    //
  }

  static String _displayStringForOption(City option) => option.name;

  @override
  Widget build(BuildContext context) {

    state = Provider.of<HotelSearchState>(context);
    state.initState(context, scaffoldKey);
    state.getCities();
    state.dateIn = dateIn;
    state.dateOut = dateOut;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Hotel', style: TextStyle(
            color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: MyColors.transparent,
              margin: const EdgeInsets.only(left: 24, right: 24),
              padding: const EdgeInsets.only(top: 24),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Autocomplete<City>(
                    displayStringForOption: _displayStringForOption,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<City>.empty();
                      }
                      return state.cities.where((City option) {
                        return option
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (City selection) {
                      state.city = selection;
                    },
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 2 - 30,
                      //   child: AvicennaTextFieldWithPrefix(
                      //     textFieldStyle: AvicennaTextFieldStyle.border,
                      //     title: 'Check-In',
                      //     prefixIcon: Icon(Icons.calendar_month),
                      //     minusWidth: 203,
                      //   ),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Check-In', style: TextStyle(
                              color: AvicennaColors.thirdBlack,
                              fontWeight: FontWeight.w400
                          )),
                          const SizedBox(height: 8),
                          AvicennaContainer(
                            useBorder: true,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2 - 30,
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.only(left: 12,
                                right: 12,
                                top: 10,
                                bottom: 10),
                            child: Text(DateFormat('EEE, dd MMM', 'id').format(
                                dateIn.toLocal()), style: const TextStyle(
                              fontSize: 16,
                            )),
                            onTap: () async {
                              var newDate = await showDatePicker(
                                context: context,
                                locale: const Locale('id', 'ID'),
                                initialDate: dateIn,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                    const Duration(days: 100)),
                              );
                              if (newDate != null) {
                                state.dateIn = newDate;
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 2 - 30,
                      //   child: AvicennaTextFieldWithPrefix(
                      //     textFieldStyle: AvicennaTextFieldStyle.border,
                      //     title: 'Check-Out',
                      //     prefixIcon: Icon(Icons.calendar_month),
                      //     minusWidth: 203,
                      //   ),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Check-Out', style: TextStyle(
                              color: AvicennaColors.thirdBlack,
                              fontWeight: FontWeight.w400
                          )),
                          const SizedBox(height: 8),
                          AvicennaContainer(
                            useBorder: true,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2 - 30,
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.only(left: 12,
                                right: 12,
                                top: 10,
                                bottom: 10),
                            child: Text(DateFormat('EEE, dd MMM', 'id').format(
                                dateOut.toLocal()), style: const TextStyle(
                              fontSize: 16,
                            )),
                            onTap: () async {
                              var newDate = await showDatePicker(
                                context: context,
                                locale: const Locale('id', 'ID'),
                                initialDate: dateOut,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                    const Duration(days: 100)),
                              );
                              if (newDate != null) {
                                state.dateOut = newDate;
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('${dateOut
                      .difference(dateIn)
                      .inDays} Malam'),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: AvicennaContainer(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: AvicennaButton(
                      text: 'Cari',
                      onPressed: () {
                        state.onSearchClick();
                      },
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}