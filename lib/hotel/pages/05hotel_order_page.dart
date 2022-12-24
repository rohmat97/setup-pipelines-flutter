import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/hotel/models/hotel_customer.dart';
import 'package:kai_wisata/hotel/providers/hotel_order_state.dart';
import 'package:provider/provider.dart';

import '../../commons/commons.dart';
import '../../commons/validator.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/checkbox.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import '../../helpers/theme.dart';
import '../arguments/hotel_room_detail_arguments.dart';
import '../models/hotel.dart';
import '../models/room.dart';
import '06hotel_checkout_page.dart';
import 'package:intl/intl.dart';

class HotelOrderPage extends StatefulWidget {
  static const routeName = '/hotel-order-page';
  const HotelOrderPage({
    Key? key
  }) : super(key: key);

  @override
  State<HotelOrderPage> createState() => _HotelOrderPageState();
}

class _HotelOrderPageState extends State<HotelOrderPage> {
  bool payOnCheckIn = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HotelOrderState state = HotelOrderState();
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute
        .of(context)!
        .settings
        .arguments as HotelRoomDetailArguments;

    state = Provider.of<HotelOrderState>(context);
    state.initState(context, scaffoldKey, args);

    return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: const Text('Rincian Pesanan', style: TextStyle(
              color: Colors.black
          )),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: MyColors.white,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child:
                Form(
                  key: _formKey,
                  child:
                  Container(
                    padding: const EdgeInsets.all(24),
                    color: MyColors.transparent,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 128,
                                child: AspectRatio(
                                  aspectRatio: 1, // 1.5,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: CachedNetworkImage(
                                        //imageUrl: args.hotel.photos.first,
                                        imageUrl: "https://via.placeholder.com/266x120",
                                        fit: BoxFit.cover,
                                        // placeholder: (context, url) => const CircularProgressIndicator(),
                                        errorWidget: (context, url,
                                            error) => const Icon(Icons.error),
                                      )
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 6),
                                    Text(args.hotel.name,
                                      style: MyTextStyle.heading1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        for (int i = 0; i < args.hotel.rate
                                            .floor(); i++) const Icon(
                                            Icons.star, size: 20,
                                            color: Color(0xFFFFC940)),
                                        for (int i = 0; i < 5 - args.hotel.rate
                                            .floor(); i++) const Icon(
                                            Icons.star, size: 20,
                                            color: Colors.grey),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.pin_drop, size: 20,
                                            color: Colors.grey),
                                        Text(args.hotel.city.name),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 - 30,
                                child: AvicennaTextField(
                                  textFieldStyle: AvicennaTextFieldStyle.border,
                                  title: 'Check-In',
                                  initialValue: DateFormat("dd MMM yyyy")
                                      .format(args.dateIn),
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 - 30,
                                child: AvicennaTextField(
                                  textFieldStyle: AvicennaTextFieldStyle.border,
                                  title: 'Check-Out',
                                  initialValue: DateFormat("dd MMM yyyy")
                                      .format(args.dateOut),
                                  enabled: false,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('1 Malam', style: MyTextStyle.info),
                          const Divider(thickness: 2, height: 34),
                          Text(args.room.name, style: MyTextStyle.heading1),
                          const SizedBox(height: 12),
                          Row(
                            children: const [
                              Icon(Icons.person),
                              SizedBox(width: 6),
                              Text('1 tamu/kamar')
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(Icons.hotel),
                              SizedBox(width: 6),
                              Text('1 ranjang single')
                            ],
                          ),
                          const Divider(thickness: 2, height: 34),
                          Text('Informasi Tamu', style: MyTextStyle.heading1),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 - 30,
                                child: AvicennaTextField(
                                  textFieldStyle: AvicennaTextFieldStyle.border,
                                  title: 'Nama Depan',
                                  controller: firstNameController,
                                  validator: (value) => TextFieldValidator.isNotEmpty(value),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 - 30,
                                child: AvicennaTextField(
                                  textFieldStyle: AvicennaTextFieldStyle.border,
                                  title: 'Nama Belakang',
                                  controller: lastNameController,
                                  validator: (value) => TextFieldValidator.isNotEmpty(value),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text('Informasi Kontak', style: MyTextStyle.heading1),
                          const SizedBox(height: 12),
                          AvicennaTextField(
                            textFieldStyle: AvicennaTextFieldStyle.border,
                            title: 'Email',
                            controller: emailController,
                            validator: (value) => TextFieldValidator.validateEmail(value),
                          ),
                          const SizedBox(height: 12),
                          AvicennaTextField(
                            textFieldStyle: AvicennaTextFieldStyle.border,
                            title: 'No. Handphone',
                            controller: phoneController,
                            validator: (value) => TextFieldValidator.validatePhone(value),
                          ),
                          const Divider(thickness: 2, height: 40),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Total Pembayaran',
                                    style: MyTextStyle.info),
                                const SizedBox(height: 14),
                                Text('Rp${moneyFormat(args.room.price)}',
                                    style: MyTextStyle.heading1),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: AvicennaButton(
                              text: 'Checkout',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {

                                  HotelCustomer cust = HotelCustomer(
                                      "Mr.",
                                      firstNameController.text,
                                      lastNameController.text,
                                      phoneController.text,
                                      emailController.text
                                  );

                                  state.onCheckOutClick(cust);
                                }
                              },
                            ),
                          )
                        ]
                    ),
                  ),
                )
            )
        )
    );
  }
}