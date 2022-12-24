import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/data/constants.dart';
import 'package:kai_wisata/flights/models/passengers/flight_passenger_model.dart';
import 'package:kai_wisata/flights/providers/flight_detail_state.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/widgets/kai_text_datepicker.dart';
import 'package:kai_wisata/widgets/kai_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingForm extends StatefulWidget {
  final String idSchDepart;
  final String idSchReturn;
  final int seats;
  final String typeText;
  final int totalSeatAdult;
  const BookingForm(this.seats, this.idSchDepart, this.idSchReturn, this.typeText, this.totalSeatAdult, {Key? key}) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  String defaultId = "KTP";
  String defaultName = "MR";
  String defaultGender = "Male";
  String defaultTypes = "Adult";
  String defaultNation = "ID";
  String defaultBirthNation = "ID";
  int defaultParent = 1;
  TextEditingController titleController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  TextEditingController idNumController = TextEditingController();
  TextEditingController pasporNumController = TextEditingController();
  TextEditingController pasporCountryController = TextEditingController();
  TextEditingController pasporDateController = TextEditingController();
  TextEditingController pasporExpDateController = TextEditingController();
  TextEditingController firtsNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nationController = TextEditingController();
  TextEditingController birthNationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController parentController = TextEditingController();
  TextEditingController typesController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  FlightDetailState state = FlightDetailState();

  bool paspor = false;
  bool ktp = true;
  String docType = "KTP";

  bool isParent = false;
  bool isChild = false;

  bool isDisabled = false;
  bool isEdit = false;

  List<FlightPassengerModel> listParent = [];

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
      titleController.text = defaultName;
      idDocController.text = defaultId;
      genderController.text = defaultGender;
      typesController.text = widget.typeText;
      nationController.text = defaultNation;
      birthNationController.text = defaultBirthNation;
    });

    if (widget.typeText == "Child" || widget.typeText == "Infant") {
      isChild = true;
    } else {
      isChild = false;
    }

    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Data Pemesan ${widget.typeText} ${widget.seats}',
                style: const TextStyle(
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      // spacing: 16,
                      runSpacing: 10,
                      direction: Axis.horizontal,
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
                              value: defaultName,
                              onChanged: (value) {
                                setState(() {
                                  defaultName = value as String;
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
                              'Jenis Dokumen Identitas',
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
                                'KTP',
                                'PASSPOR',
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
                              hint: const Text("Pilih Dokumen Identitas"),
                              value: defaultId,
                              onChanged: (value) {
                                setState(() {
                                  if (value == "KTP") {
                                    paspor = false;
                                    ktp = true;
                                    docType = "KTP";
                                  } else {
                                    paspor = true;
                                    ktp = false;
                                    docType = "PASSPOR";
                                  }
                                  defaultId = value as String;
                                  idDocController.text = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: ktp,
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
                                    'Nomor Identitas',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              KaiTextField(
                                widget: const Text(''),
                                obscure: false,
                                textController: idNumController,
                                keyboardType: TextInputType.number,
                                hint: 'Masukkan Nomor Identitas',
                                color: KaiColor.homeBackground,
                                validator: (value) {
                                  if (value!.length < 16) {
                                    return "Tidak Boleh kurang dari 16 digit";
                                  } else if (value.length > 16) {
                                    return "Tidak Boleh lebih dari 16 digit";
                                  } else if (value == null || value.isEmpty) {
                                    return "Wajib diisi dan tidak Boleh Kosong!";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )
                        ),
                        Visibility(
                          visible: paspor,
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
                                    'Nomor Paspor',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              KaiTextField(
                                widget: const Text(''),
                                obscure: false,
                                textController: pasporNumController,
                                hint: 'Masukkan Nomor Paspor',
                                color: KaiColor.homeBackground,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 18.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Paspor Negara',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              KaiTextField(
                                widget: const Text(''),
                                obscure: false,
                                textController: pasporCountryController,
                                hint: 'Masukkan Paspor Negara',
                                color: KaiColor.homeBackground,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 18.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Tanggal Paspor',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              KaiTextField(
                                widget: const Text(''),
                                obscure: false,
                                textController: pasporDateController,
                                hint: 'Masukkan Tanggal Paspor',
                                color: KaiColor.homeBackground,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 18.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Tanggal Kadaluarsa Passpor',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              KaiTextField(
                                widget: const Text(''),
                                obscure: false,
                                textController: pasporExpDateController,
                                hint: 'Masukkan Tanggal Kadaluarsa Passpor',
                                color: KaiColor.homeBackground,
                              ),
                            ],
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
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
                              'Tanggal Lahir',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        KaiTextDatePicker(
                          widget: const Text(''),
                          obscure: false,
                          textController: birthDateController,
                          hint: 'Masukkan Tanggal Lahir',
                          color: KaiColor.homeBackground,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
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
                              'Kebangsaan',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            items: listOfCountries.map((value) {
                              return DropdownMenuItem(
                                value: value["code"],
                                // child: Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(value["name"]),
                                //   ],
                                // ),
                                child: Wrap(
                                  spacing: 8.0, // gap between adjacent chips
                                  runSpacing: 4.0, // gap between lines
                                  direction: Axis.horizontal, // main axis (rows or columns)
                                  children: [
                                    Text(
                                      value["name"],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            hint: const Text("Pilih Kebangsaan"),
                            value: defaultNation,
                            onChanged: (value) {
                              setState(() {
                                defaultNation = value as String;
                                nationController.text = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
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
                              'Negara Kelahiran',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            items: listOfCountries.map((value) {
                              return DropdownMenuItem(
                                value: value["code"],
                                // child: Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(value["name"]),
                                //   ],
                                // ),
                                child: Wrap(
                                  spacing: 8.0, // gap between adjacent chips
                                  runSpacing: 4.0, // gap between lines
                                  direction: Axis.horizontal, // main axis (rows or columns)
                                  children: [
                                    Text(
                                      value["name"],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            hint: const Text("Pilih Negara Kelahiran"),
                            value: defaultBirthNation,
                            onChanged: (value) {
                              setState(() {
                                defaultBirthNation = value as String;
                                birthNationController.text = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
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
                              'Jenis Kelamin',
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
                                'Male',
                                'Female',
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
                              hint: const Text("Pilih Jenis Kelamin"),
                              value: defaultGender,
                              onChanged: (value) {
                                setState(() {
                                  defaultGender = value as String;
                                  genderController.text = value;
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
                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //     left: 18.0,
                        //   ),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       'Pilih Tipe',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 18, right: 18),
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width,
                        //     child: DropdownButtonFormField(
                        //       items: <String>[
                        //         'Adult',
                        //         'Child',
                        //         'Infant',
                        //       ].map<DropdownMenuItem<String>>((String value) {
                        //         return DropdownMenuItem<String>(
                        //           value: value,
                        //           child: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 value
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       }).toList(),
                        //       hint: const Text("Pilih Tipe"),
                        //       value: defaultTypes,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           defaultTypes = value as String;
                        //           typesController.text = value;
                        //           if (value == "Child" || value == "Infant") {
                        //             isChild = true;
                        //           } else {
                        //             isChild = false;
                        //           }
                        //         });
                        //       },
                        //       decoration: const InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // listParent != [] && isParent ? Visibility(
                        //   visible: isParent,
                        //   child: Wrap(
                        //     runSpacing: 10,
                        //     children: [
                        //       const Padding(
                        //         padding: EdgeInsets.only(
                        //           left: 18.0,
                        //         ),
                        //         child: Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text(
                        //             'Nama Orang Tua',
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.w600,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 18, right: 18),
                        //         child: DropdownButtonFormField(
                        //           items: listParent.map((value) {
                        //             return DropdownMenuItem(
                        //               value: value.idx,
                        //               child: Row(
                        //                 mainAxisSize: MainAxisSize.min,
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text('${value.firtsName} ${value.lastName}'),
                        //                 ],
                        //               ),
                        //             );
                        //           }).toList(),
                        //           hint: const Text("Pilih Nama Orang Tua"),
                        //           value: defaultParent,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               defaultParent = value as int;
                        //               parentController.text = value.toString();
                        //               listParent = state.passengers;
                        //             });
                        //           },
                        //           decoration: const InputDecoration(
                        //             border: OutlineInputBorder(borderRadius: BorderRadius.all(
                        //                 Radius.circular(10),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ) : const SizedBox(),
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
                            SharedPreferences dataPassenger = await SharedPreferences.getInstance();
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                if (widget.typeText == "Adult") {
                                  var json = {
                                    'index': widget.seats,
                                    'id_number': idNumController.text,
                                    'title_name': titleController.text,
                                    'first_name': firtsNameController.text,
                                    'last_name': lastNameController.text,
                                    'birth_date': birthDateController.text,
                                    'gender': genderController.text,
                                    'nationality': nationController.text,
                                    'birth_country': birthNationController.text,
                                    'doc_type': idDocController.text,
                                    'parent': parentController.text,
                                    'passport_number': pasporNumController.text,
                                    'passport_issued_country': pasporCountryController.text,
                                    'passport_issued_date': pasporDateController.text,
                                    'passport_expired_date': pasporExpDateController.text,
                                    'type': typesController.text,
                                  };
                                  var passenger = FlightPassengerModel.fromJson(json);
                                  state.savePassengerAdult(passenger, widget.seats);
                                  // print(jsonEncode(state.passengers));
                                  if (state.passengers.isNotEmpty) {
                                    isParent = true;
                                    for (var pr in state.passengers) {
                                      listParent.add(pr);
                                    }
                                  } else {
                                    isParent = false;
                                  }
                                  dataPassenger.setString("passenger_data_${widget.typeText}_${widget.seats}", jsonEncode(passenger.toJson()));
                                  print(dataPassenger.getString("passenger_data_${widget.typeText}_${widget.seats}"));
                                } else if (widget.typeText == "Child" || widget.typeText == "Infant") {
                                  var json = {
                                    'index': widget.seats,
                                    'id_number': idNumController.text,
                                    'title_name': titleController.text,
                                    'first_name': firtsNameController.text,
                                    'last_name': lastNameController.text,
                                    'birth_date': birthDateController.text,
                                    'gender': genderController.text,
                                    'nationality': nationController.text,
                                    'birth_country': birthNationController.text,
                                    'doc_type': idDocController.text,
                                    'parent': "0",
                                    'passport_number': pasporNumController.text,
                                    'passport_issued_country': pasporCountryController.text,
                                    'passport_issued_date': pasporDateController.text,
                                    'passport_expired_date': pasporExpDateController.text,
                                    'type': typesController.text,
                                  };
                                  var passengerChildOrInfant = FlightPassengerModel.fromJson(json);
                                  if (widget.typeText == "Child") {
                                    state.savePassengerChild(passengerChildOrInfant, widget.totalSeatAdult);
                                  } else {
                                    state.savePassengerInfant(passengerChildOrInfant, widget.totalSeatAdult);
                                  }
                                  dataPassenger.setString("passenger_data_${widget.typeText}_${widget.seats}", jsonEncode(passengerChildOrInfant.toJson()));
                                  print(dataPassenger.getString("passenger_data_${widget.typeText}_${widget.seats}"));
                                  if (state.passengers.isNotEmpty) {
                                    // isParent = true;
                                    // for (var pr in state.passengers) {
                                    //   listParent.add(pr);
                                    // }

                                    // var json = {
                                    //   'index': widget.seats,
                                    //   'id_number': idNumController.text,
                                    //   'title_name': titleController.text,
                                    //   'first_name': firtsNameController.text,
                                    //   'last_name': lastNameController.text,
                                    //   'birth_date': birthDateController.text,
                                    //   'gender': genderController.text,
                                    //   'nationality': nationController.text,
                                    //   'birth_country': birthNationController.text,
                                    //   'doc_type': idDocController.text,
                                    //   'parent': 0,
                                    //   'passport_number': pasporNumController.text,
                                    //   'passport_issued_country': pasporCountryController.text,
                                    //   'passport_issued_date': pasporDateController.text,
                                    //   'passport_expired_date': pasporExpDateController.text,
                                    //   'type': typesController.text,
                                    // };
                                    // var passengerChildOrInfant = FlightPassengerModel.fromJson(json);
                                    // if (widget.typeText == "Child") {
                                    //   state.savePassengerChild(passengerChildOrInfant, widget.totalSeatAdult);
                                    // } else {
                                    //   state.savePassengerInfant(passengerChildOrInfant, widget.totalSeatAdult);
                                    // }
                                    // dataPassenger.setString("passenger_data_${widget.typeText}_${widget.seats}", jsonEncode(passengerChildOrInfant.toJson()));
                                    // print(dataPassenger.getString("passenger_data_${widget.typeText}_${widget.seats}"));
                                  } else {
                                    isParent = false;
                                  }
                                } else {
                                  // isChild = false;
                                }
                                isDisabled = true;
                                isEdit = true;
                              });
                            }
                          },
                          child: Text(isEdit ? 'Ubah Data' : 'Simpan Penumpang ${widget.typeText} ${widget.seats}'),
                        ),
                      ),
                    ),
                  ),
                  tileDivider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}