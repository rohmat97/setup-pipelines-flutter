import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/commons/validator.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/passenger_data_arguments.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_phone_number.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/passenger_data_state.dart';

class PassengerDataPage extends StatefulWidget {
  static const routeName = '/passenger-data-pages';

  const PassengerDataPage({Key? key}) : super(key: key);

  @override
  State<PassengerDataPage> createState() => _PassengerDataPageState();
}

class _PassengerDataPageState extends State<PassengerDataPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PassengerDataState? state;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  Widget tileDivider({double height = 22}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(
        height: height,
        thickness: .25,
        color: KaiColor.black,
      ),
    );
  }

  Widget buildActionTile(String title, String contentText, String icon,
      {double subtitlePadding = 10}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: KaiTextStyle.smallBold.apply(color: KaiColor.black),
          ),
          const SizedBox(height: 6.35),
          Row(
            children: [
              Image(image: AssetImage(icon)),
              SizedBox(width: subtitlePadding),
              Text(
                contentText,
                style: KaiTextStyle.smallThin.apply(color: KaiColor.black),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildNewTile(String title, String contentText, String icon,
      {Function? onTap, double subtitlePadding = 10}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: KaiTextStyle.smallBold.apply(
              color: KaiColor.black,
              fontSizeDelta: 3.0,
            ),
          ),
          const SizedBox(height: 6.35),
          Row(
            children: [
              SvgPicture.asset(icon, height: 20),
              SizedBox(width: subtitlePadding),
              Text(
                contentText,
                style: KaiTextStyle.bodySmallMedium.apply(
                  color: KaiColor.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as PassengerDataArguments;

    state = Provider.of<PassengerDataState>(context);
    state?.initState(context, scaffoldKey, args);

    nameController.text = state!.name;
    idController.text = state!.ic;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
          child:
          ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(1.0),
              children: <Widget>[
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
                              onTap: () => state?.onBackButton(),
                            ),
                          ),
                          Text(
                            'Data Penumpang',
                            style: KaiTextStyle.titleSmallBold
                                .apply(color: KaiColor.black),
                          ),
                        ],
                      ),
                    ),

                    Form(
                      key: _formKey,
                      child:

                      Column(
                        children: [
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 18.0, top: 10.0, bottom: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Title',
                                style: KaiTextStyle.bodySmallBold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18.0),
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: KaiColor.neutral11,
                                  filled: true,
                                  suffixIcon: widget,
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                        color: KaiColor.blue),
                                  ),
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                disabledItemFn: (String s) => s.startsWith('P'),
                                fit: FlexFit.loose,
                              ),
                              items: const ["Pilih", "Mr.", "Mrs.", 'Ms.'],
                              onChanged: (title) => state?.setTitle(title!),
                              selectedItem: state?.title,
                              validator: (value) =>
                                  TextFieldValidator.isNotEmpty(value),
                            ),
                          ),
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 18.0, top: 10.0, bottom: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nama Penumpang',
                                style: KaiTextStyle.bodySmallBold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          KaiTextField(
                            textController: nameController,
                            hint: 'Nama penumpang',
                            obscure: false,
                            widget: const Text(''),
                            color: KaiColor.neutral11,
                            validator: (value) =>
                                TextFieldValidator.isNotEmpty(value),
                          ),
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 18.0, top: 10.0, bottom: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tipe Identitas',
                                style: KaiTextStyle.bodySmallBold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18.0),
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: KaiColor.neutral11,
                                  filled: true,
                                  suffixIcon: widget,
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                        color: KaiColor.blue),
                                  ),
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                disabledItemFn: (String s) => s.startsWith('T'),
                                fit: FlexFit.loose,
                              ),
                              items: const [
                                "Tipe Identitas",
                                "KTP/SIM",
                                "Paspor"
                              ],
                              validator: (value) =>
                                  TextFieldValidator.isNotEmpty(value),
                              onChanged: (src) => state?.setSource(src!),
                              selectedItem: state?.src,
                            ),
                          ),
                          const Padding(
                            padding:
                            EdgeInsets.only(
                                left: 18.0, top: 10.0, bottom: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'No. Identitas',
                                style: KaiTextStyle.bodySmallBold,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          KaiTextField(
                            textController: idController,
                            hint: 'No. identitas',
                            obscure: false,
                            widget: const Text(''),
                            color: KaiColor.neutral11,
                            validator: (value) =>
                                TextFieldValidator.isNotEmpty(value),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              '*Masukkan 16 angka NIK sesuai KTP. Penumpang yang tidak memiliki KTP dapat menggunakan NIK yang tercantum pada Kartu Keluarga',
                              textAlign: TextAlign.left,
                              style: KaiTextStyle.bodySmallMedium,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]
          )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: KaiButton(
          text: 'Simpan',
          onClick: () async {
            if (_formKey.currentState!.validate()) {
              var passenger = {
                "name": nameController.text,
                "identity": idController.text,
              };
              // print(passenger);
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("passenger", json.encode(passenger));
              state?.savePassenger(
                nameController.text, idController.text
              );
            }
          },
          buttonColor: KaiColor.blue,
          textColor: KaiColor.white,
          sideColor: KaiColor.blue,
        ),
      ),
    );
  }
}
