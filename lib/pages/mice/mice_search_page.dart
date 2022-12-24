import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/container.dart';
import '../../commons/widgets/dropdown.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import 'mice_list_page.dart';

class MiceSearchPage extends StatefulWidget {
  static const routeName = '/mice-search-pages';

  const MiceSearchPage({Key? key}) : super(key: key);

  @override
  State<MiceSearchPage> createState() => _MiceSearchPageState();
}

class _MiceSearchPageState extends State<MiceSearchPage> {

  String tujuan = '';

  @override
  void initState() {
    super.initState();
    //
  }

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('MICE',style: TextStyle(
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cari Ruangan Sesuai Kebutuhan Anda dengan Mudah', style: MyTextStyle.heading1),
                  const SizedBox(height: 24),
                  AvicennaTextFieldWithPrefix(
                    textFieldStyle: AvicennaTextFieldStyle.border,
                    title: 'Lokasi',
                    prefixIcon: Icon(Icons.pin_drop),
                    minusWidth: 16,
                    hintText: 'Pilih Lokasi',
                    onChanged: (val) {
                      setState(() {
                        tujuan = val;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 2 - 30,
                      //   child: AvicennaTextFieldWithPrefix(
                      //     textFieldStyle: AvicennaTextFieldStyle.border,
                      //     title: 'Waktu Reservasi',
                      //     prefixIcon: Icon(Icons.calendar_month),
                      //     minusWidth: 203,
                      //     initialValue: date != null ? date.toString() : '',
                      //     onPressed: () async {
                      //       var newDate = await showDatePicker(
                      //         context: context,
                      //         locale: const Locale('id', 'ID'),
                      //         initialDate: date ?? DateTime.now(),
                      //         firstDate: DateTime.now(),
                      //         lastDate: DateTime.now().add(const Duration(days: 100)),
                      //       );
                      //       if (newDate != null) {
                      //         setState(() {
                      //           date = newDate;
                      //         });
                      //       }
                      //     },
                      //   ),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Waktu Reservasi', style: const TextStyle(
                              color: AvicennaColors.thirdBlack,
                              fontWeight: FontWeight.w400
                          )),
                          SizedBox(height: 8),
                          AvicennaContainer(
                            useBorder: true,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                            child: Text(DateFormat('EEE, dd MMM', 'id').format(date.toLocal()), style: const TextStyle(
                              fontSize: 16,
                            )),
                            onTap: () async {
                              var newDate = await showDatePicker(
                                context: context,
                                locale: const Locale('id', 'ID'),
                                initialDate: date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 100)),
                              );
                              if (newDate != null) {
                                setState(() {
                                  date = newDate;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        child: AvicennaDropDownPicker(
                          textFieldStyle: AvicennaTextFieldStyle.border,
                          title: 'Kapasitas',
                          onChanged: (val) {

                          },
                          items: [
                            '100 Orang',
                            '200 Orang',
                            '> 200 Orang',
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: AvicennaContainer(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                width: MediaQuery.of(context).size.width,
                child: AvicennaButton(
                  text: 'Cari',
                  onPressed: () {
                    navigateToPage(context, MiceListPage(title: tujuan));
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