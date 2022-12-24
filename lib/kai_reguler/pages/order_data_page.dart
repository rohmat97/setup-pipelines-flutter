import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/commons/validator.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/order_data_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/providers/input_passenger_state.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_phone_number.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:provider/provider.dart';

import '../arguments/input_passenger_arguments.dart';
import '../providers/order_data_state.dart';

class OrderDataPage extends StatefulWidget {
  static const routeName = '/order-data-pages';

  const OrderDataPage({Key? key}) : super(key: key);

  @override
  State<OrderDataPage> createState() => _OrderDataPageState();
}

class _OrderDataPageState extends State<OrderDataPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  OrderDataState? state;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  initState() {
    super.initState();
    codeController.text = '+62';
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
    final args =
        ModalRoute.of(context)!.settings.arguments as OrderDataArguments;
    state = Provider.of<OrderDataState>(context);
    state?.initState(context, scaffoldKey, args);

    nameController.text = state!.name;
    phoneController.text = state!.phone;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: KaiColor.neutral11,
      body: SafeArea(
          child: ListView(
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
                        'Data Pemesan',
                        style: KaiTextStyle.titleSmallBold
                            .apply(color: KaiColor.black),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
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
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
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
                                borderSide: BorderSide(color: KaiColor.blue),
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
                        padding: EdgeInsets.only(
                            left: 18.0, top: 10.0, bottom: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Data Pemesan',
                            style: KaiTextStyle.bodySmallBold,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      KaiTextField(
                        textController: nameController,
                        hint: 'Nama Pemesan',
                        obscure: false,
                        widget: const Text(''),
                        color: KaiColor.neutral11,
                        validator: (value) =>
                            TextFieldValidator.isNotEmpty(value),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 18.0, top: 10.0, bottom: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nomor Telepon',
                            style: KaiTextStyle.bodySmallBold,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                                right: 18.0,
                              ),
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: KaiColor.black),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '+62',
                                    style: KaiTextStyle.bodyLargeMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: KaiPhoneNumber(
                              textController: phoneController,
                              hint: '',
                              obscure: false,
                              widget: const Text(''),
                              color: KaiColor.neutral11,
                              validator: (value) {
                                // if (!TextFieldValidator.isNotEmpty(value)) {
                                //   return null;
                                // }
                                // if (int.tryParse(value!) == null) {
                                //   return "Nomor Telepon harus angka.";
                                // }

                                // return null;

                                if (TextFieldValidator.isNotEmpty(value) !=
                                        null ||
                                    int.tryParse(value!) == null) {
                                  return "Nomor Telepon harus angka.";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          '*Kami akan mengirimkan konfirmasi pesanan Anda ke kontak diatas',
                          textAlign: TextAlign.left,
                          style: KaiTextStyle.bodySmallMedium,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: KaiButton(
          text: 'Simpan',
          onClick: () {
            if (_formKey.currentState!.validate()) {
              state?.saveDataCaller(DataCallerCart(
                  state!.title, nameController.text, phoneController.text));
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
