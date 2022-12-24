import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:kai_wisata/commons/validator.dart';
import 'package:kai_wisata/flights/caches/contact_cache.dart';
import 'package:kai_wisata/flights/models/contacts/flight_contact_model.dart';
import 'package:kai_wisata/flights/providers/flight_detail_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_button.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingContactForm extends StatefulWidget {
  final String idSchDep;
  final String idSchRet;
  const BookingContactForm(this.idSchDep, this.idSchRet, {Key? key}) : super(key: key);

  @override
  State<BookingContactForm> createState() => _BookingContactFormState();
}

class _BookingContactFormState extends State<BookingContactForm> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  
  String defaultTitle = "MR";
  String defaultCode = "62";
  String defaultArea = "812";
  TextEditingController titleController = TextEditingController();
  TextEditingController firtsNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController areaCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FlightDetailState state = FlightDetailState();

  bool isDisabled = false;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
  }

  getInit() async {
    // dataContact = await SharedPreferences.getInstance();
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

  @override
  Widget build(BuildContext context) {

    setState(() {
      titleController.text = defaultTitle;
      countryCodeController.text = defaultCode;
      areaCodeController.text = defaultArea;
    });

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Data Kontak',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            Card(
              elevation: 4,
              shadowColor: Colors.black,
              color: KaiColor.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Title',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              items: <String>[
                                'MR',
                                'MRS',
                                'MISS',
                                'MSTR',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              hint: const Text("Pilih Title"),
                              value: defaultTitle,
                              onChanged: (value) {
                                setState(() {
                                  defaultTitle = value as String;
                                  titleController.text = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nama Depan',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        KaiTextField(
                          widget: const Text(''),
                          obscure: false,
                          textController: firtsNameController,
                          hint: 'Masukkan Nama Depan',
                          color: KaiColor.homeBackground,
                          validator: (valFs) {
                            if (valFs == null || valFs.isEmpty) {
                              return "Wajib diisi dan tidak Boleh Kosong!";
                            }
                            return null;
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nama Belakang',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        KaiTextField(
                          widget: const Text(''),
                          obscure: false,
                          textController: lastNameController,
                          hint: 'Masukkan Nama Belakang',
                          color: KaiColor.homeBackground,
                          validator: (valLs) {
                            if (valLs == null || valLs.isEmpty) {
                              return "Wajib diisi dan tidak Boleh Kosong!";
                            }
                            return null;
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kontak Email',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        KaiTextField(
                          widget: const Text(''),
                          obscure: false,
                          textController: emailController,
                          validator: (value) =>
                              TextFieldValidator.validateEmail(value),
                          hint: 'contoh@email.com',
                          color: KaiColor.homeBackground,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kode Telepon Negara',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              items: <String>[
                                '62',
                                '93',
                                '1',
                                '44',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              hint: const Text("Pilih Kode Telepon Negara"),
                              value: defaultCode,
                              onChanged: (value) {
                                setState(() {
                                  defaultCode = value as String;
                                  countryCodeController.text = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kode Telepon Area / Operator',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              items: <String>[
                                '812',
                                '815',
                                '838',
                                '852',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              hint: const Text("Pilih Kode Telepon Area / Operator"),
                              value: defaultArea,
                              onChanged: (value) {
                                setState(() {
                                  defaultArea = value as String;
                                  areaCodeController.text = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 18.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nomor Terakhir Dari Telepon / HP',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        KaiTextField(
                          widget: const Text(''),
                          obscure: false,
                          textController: phoneController,
                          keyboardType: TextInputType.number,
                          hint: 'Masukkan Nomor Terakhir Dari Telepon / HP',
                          color: KaiColor.homeBackground,
                          validator: (valPh) {
                            if (valPh!.length > 9) {
                              return "Sisa nomor Telepon / Handphone tidak boleh lebih dari 9 digit";
                            } else if (valPh == null || valPh.isEmpty) {
                              return "Wajib diisi dan tidak Boleh Kosong!";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  tileDivider(),
                  Container(
                    margin: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: KaiColor.white,
                            backgroundColor: isEdit ? KaiColor.yellow : KaiColor.blue,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(MediaQuery.of(context).size.width, 40),
                            side: const BorderSide(color: KaiColor.blue),
                          ),
                          onPressed: isDisabled && isEdit ? () async {
                            setState(() {
                              isDisabled = false;
                              isEdit = false;
                            });
                          } : () async {
                            SharedPreferences dataContact = await SharedPreferences.getInstance();
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                // state.reqBodyContacts(widget.idSchDep, widget.idSchRet, titleController.text, firtsNameController.text, lastNameController.text, countryCodeController.text, areaCodeController.text, phoneController.text, "");
                                var json = {
                                  'id_schedule_departure': widget.idSchDep,
                                  'id_schedule_return': widget.idSchRet,
                                  'contact_title': titleController.text,
                                  'contact_first_name': firtsNameController.text,
                                  'contact_last_name': lastNameController.text,
                                  'contact_country_code_phone': countryCodeController.text,
                                  'contact_area_code_phone': areaCodeController.text,
                                  'contact_remaining_phone': phoneController.text,
                                  'contact_email': emailController.text,
                                  'insurance': "",
                                };
                                var contactModel = FlightContactModel.fromJson(json);
                                // ContactCache.instance.saveContacts(contactModel);
                                dataContact.setString("ContactData", jsonEncode(contactModel.toJson()));
                                // state.setContact(contactModel);
                                isDisabled = true;
                                isEdit = true;
                              });
                            } else {

                            }
                          },
                          child: Text(isEdit ? 'Edit' : 'Simpan Kontak'),
                        ),
                      ),
                    ),
                  ),
                  tileDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}