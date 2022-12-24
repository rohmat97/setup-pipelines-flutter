import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_reguler/arguments/booking_loading_arguments.dart';
import 'package:kai_wisata/kai_reguler/arguments/input_passenger_arguments.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_cart.dart';
import 'package:kai_wisata/kai_reguler/pages/03input_passenger_page.dart';
import 'package:kai_wisata/kai_reguler/pages/05selected_payment_page.dart';
import 'package:kai_wisata/widgets/kai_loading_indicator.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/theme.dart';
import '../arguments/selected_payment_arguments.dart';
import '../services/regular_ticket_service.dart';

class BookingLoadingPage extends StatelessWidget {

  static const routeName = '/booking-loading-pages';
  BookingLoadingArguments? args;

  BookingLoadingPage({Key? key}) : super(key: key);

  void showError(BuildContext context, String error) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "ERROR",
      desc: error,
      buttons: [
        DialogButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(
                  context, InputPassengerPage.routeName,
                  arguments: InputPassengerArguments(
                      args!.schedule, args!.bookingCart)),
          width: 120,
        )
      ],
    ).show();
  }

  void book(BuildContext context, RailBookingCart bookingInfo) async {
    try {
      var dataBookCart = await RegularTicketService.bookCart(bookingInfo);
      
      if (dataBookCart != "") {
        Map<String, dynamic> dataBooking = {
          "cart_depart_id": '${dataBookCart["depart_cart"]["id"]}',
          "cart_return_id": "",
        };
        dataBooking.addAll(bookingInfo.toJsonPassenger());
        var dataBook = await RegularTicketService.book(dataBooking);
        if (dataBook != "") {
          Navigator.pushReplacementNamed(context, SelectedPaymentPage.routeName,
            arguments: SelectedPaymentArguments(
                args!.schedule, args!.bookingCart, dataBook["booking_code"], dataBook["transaction_id"]));
        }
      } else {
        showError(context,
            "Error on booking the ticket, please contact administrator");
      }
    } catch (e) {
      showError(context, "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as BookingLoadingArguments;
    book(context, args!.bookingCart);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Please Wait ...',
          style: KaiTextStyle.titleSmallBold.apply(color: KaiColor.white),
        ),
        backgroundColor: KaiColor.blue,
        centerTitle: true,
      ),
      body: const KaiLoadingIndicator()
    );
  }
}