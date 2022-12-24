
import 'package:flutter/material.dart';
import 'package:kai_wisata/flights/arguments/flight_booking_arguments.dart';
import 'package:kai_wisata/flights/arguments/flight_detail_arguments.dart';
import 'package:kai_wisata/flights/models/addon/flight_addon_model.dart';
import 'package:kai_wisata/flights/models/contacts/flight_contact_model.dart';
import 'package:kai_wisata/flights/models/flight_booking_model.dart';
import 'package:kai_wisata/flights/models/flight_detail_model.dart';
import 'package:kai_wisata/flights/models/passengers/flight_passenger_model.dart';
import 'package:kai_wisata/flights/pages/flight_booking_page.dart';
import 'package:kai_wisata/flights/services/flight_service.dart';
import 'package:kai_wisata/user/models/auth_cache.dart';
import 'package:kai_wisata/user/models/kai_user.dart';

class FlightDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  FlightDetailArguments? args;

  int? adultSeat;
  int? childSeat;
  int? infantSeat;
  
  KAIUser? user;

  String? idSchDepart;
  String? idSchReturn;

  List<FlightContactModel> _contact = [];
  List<FlightContactModel> get contact => _contact;

  List<FlightAddOnModel> _addon = [];
  List<FlightAddOnModel> get addon => _addon;

  Map<String, dynamic> reqBodyContact = {};

  List<FlightPassengerModel> _passengers = [];

  List<FlightPassengerModel> get passengers => _passengers;

  set passengers(List<FlightPassengerModel> passengers) {
    _passengers = passengers;
    notifyListeners();
  }
  List<FlightPassengerModel> passengersChild = [];
  List<FlightPassengerModel> passengersInfant = [];

  FlightDetailModel? _detail;

  FlightDetailModel? get detail => _detail;

  FlightBookingModel? _booking;
  FlightBookingModel? get booking => _booking;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    FlightDetailArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
    user = AuthCache.instance.getUser();
  }

  set booking(FlightBookingModel? booking) {
    _booking = booking;
    notifyListeners();
  }

  set detail(FlightDetailModel? detail) {
    _detail = detail;
    notifyListeners();
  }

  set addon(List<FlightAddOnModel> addon) {
    _addon = addon;
    notifyListeners();
  }

  void setSeat(int theSeat){
    adultSeat = theSeat;

    notifyListeners();
  }

  void setContactBody(Map<String, dynamic> contact) {
    reqBodyContact = contact;
    notifyListeners();
  }

  String getSeatAdult() {

    return "$adultSeat";
  }

  set contact(List<FlightContactModel> contact) {
    _contact = contact;
    notifyListeners();
  }

  setContact(FlightContactModel contact) {
    _contact.add(contact);
    notifyListeners();
  }

  void setIdSchDepart(String idDepart){
    idSchDepart = idDepart;

    notifyListeners();
  }

  void setIdSchReturn(String idReturn){
    idSchReturn = idReturn;

    notifyListeners();
  }

  Future<bool> getScheduleDetail(String? idscdep, String? idscret, String? accCode) async {
    try {
      FlightDetailModel detail = await FlightService().getScheduleDetail(idScheduleDepart: idscdep, idScheduleReturn: idscret, accCode: accCode);

      _detail = detail;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAddOn(FlightContactModel contact) async {
    try {
      List<FlightAddOnModel> addon = await FlightService().getAddOn(contact);

      _addon = addon;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> bookings(String? idscdep, String? idscret) async {
    try {
      FlightBookingModel booking = await FlightService().booking(idScheduleDepart: idscdep, idScheduleReturn: idscret);

      _booking = booking;

      return true;
    } catch (e) {
      return false;
    }
  }

  void onNextButton() {
    Navigator.pushNamed(context!, FlightBookingPage.routeName, arguments: flightBookingArguments());
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  FlightBookingArguments flightBookingArguments() {
    return FlightBookingArguments(idSchDepart, idSchReturn, booking);
  }

  savePassengerAdult(FlightPassengerModel passenger, int adultSeat) {
    passengers.clear();
    // passengers.add(passenger);
    // int psg = passengers.indexWhere((element) {
    //   print(json.encode(element));
    //   return element.idx == passenger.idx;
    // });
    // print(passengerExist(passenger));
    if (passengerExist(passenger) == true) {
      int psg = _passengers.indexWhere((element) => element.idx == passenger.idx);
      _passengers[psg] = passenger;
    } else {
      _passengers.add(passenger);
    }
    // if (passengers.length < adultSeat) {
    //   // // passengers.add(passenger);
    //   // if (passengers.isEmpty) {
    //   //   passengers.add(passenger);
    //   // } else {
        
    //   // }
    //   var psg = passengers.indexWhere((element) => element.idx == passenger.idx);
    //   if (psg == -1) {
    //     passengers.add(passenger);
    //   } else {
    //     passengers[psg] = passenger;
    //   }
    // }

    notifyListeners();
  }

  void savePassengerChild(FlightPassengerModel passenger, int childSeat) {
    // passengers.clear();
    if (passengersChild.length != childSeat) {
      // passengers.add(passenger);
      if (passengersChild.isEmpty) {
        passengersChild.add(passenger);
      } else {
        var psg = passengersChild.indexWhere((element) => element.idx == passenger.idx);
        if (psg == -1) {
          passengersChild.add(passenger);
        } else {
          passengersChild[psg] = passenger;
        }
      }
    }
    // print(json.encode(passengersChild));

    notifyListeners();
  }

  void savePassengerInfant(FlightPassengerModel passenger, int infantSeat) {
    // passengers.clear();
    if (passengersInfant.length != infantSeat) {
      // passengers.add(passenger);
      if (passengersInfant.isEmpty) {
        passengersInfant.add(passenger);
      } else {
        var psg = passengersInfant.indexWhere((element) => element.idx == passenger.idx);
        if (psg == -1) {
          passengersInfant.add(passenger);
        } else {
          passengersInfant[psg] = passenger;
        }
      }
    }
    // print(json.encode(passengersInfant));

    notifyListeners();
  }

  passengerExist(FlightPassengerModel passenger) {
    int psg = _passengers.indexWhere((element) => element.idx == passenger.idx);
    if (psg == -1) {
      return false;
    } else {
      return true;
    }
  }
}