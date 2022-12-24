import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/models/flight_payment_method_model.dart';
import 'package:kai_wisata/kai_reguler/services/regular_ticket_service.dart';

class SelectPaymentMethodState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;

  List<FlightPaymentMethodModel> payments = [];
  bool isLoaded = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey
  ) {
    context = ctx;
    key = scaffoldKey;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  void onNextButton() {
    Navigator.pop(context!);
  }

  Future<bool> paymentMethods() async {
    if (!isLoaded) {
      payments = await RegularTicketService.paymentMethods();
      isLoaded = true;
      notifyListeners();
    }

    return true;
  }
}
