import 'package:flutter/material.dart';
import 'package:kai_wisata/kai_wisata/arguments/tourism_customer_arguments.dart';
import 'package:kai_wisata/kai_wisata/arguments/tourism_detail_arguments.dart';
import 'package:kai_wisata/kai_wisata/models/tourism_customer.dart';
import 'package:kai_wisata/kai_wisata/pages/04tourism_detail_page.dart';

import '../../commons/validator.dart';

class TourismCustomerState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  TourismCustomerArguments? args;

  String name = "";
  String email = "";
  String phone = "";
  String company = "";
  String address = "";

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
    TourismCustomerArguments args,
  ) {
    context = ctx;
    key = scaffoldKey;
    this.args = args;
    name = args.customer.name;
    email = args.customer.email;
    phone = args.customer.phone;
    company = args.customer.company;
    address = args.customer.address;
  }

  void setName(String name) {
    name = name;
    notifyListeners();
  }

  void setEmail(String name) {
    email = name;
    notifyListeners();
  }

  void setPhone(String name) {
    phone = name;
    notifyListeners();
  }

  void setCompany(String name) {
    company = name;
    notifyListeners();
  }

  void setAddress(String name) {
    address = name;
    notifyListeners();
  }

  List<dynamic> onBackButton(
      String name, String email, String phone, String company, String address) {
    var newCust = TourismCustomer(name, email, phone, company, address,
        args!.customer.seat, args!.customer.note);

    if (TextFieldValidator.isNotEmpty(name) != null) {
      return [true, "Nama tidak boleh kosong"];
    } else if (TextFieldValidator.isNotEmpty(email) != null) {
      return [true, "Email tidak boleh kosong"];
    } else if (TextFieldValidator.validateEmail(email) != null) {
      return [true, "Masukkan email yang valid"];
    } else if (TextFieldValidator.isNotEmpty(phone) != null ||
        int.tryParse(phone) == null) {
      return [true, "Masukkan nomor telepon yang valid"];
    } else if (TextFieldValidator.isNotEmpty(company) != null) {
      return [true, "Nama Instansi tidak boleh kosong"];
    } else if (TextFieldValidator.isNotEmpty(address) != null) {
      return [true, "Alamat tidak boleh kosong"];
    }

    name = name;
    email = email;
    phone = phone;
    company = company;
    address = address;

    Navigator.pushReplacementNamed(context!, TourismDetailPage.routeName,
        arguments: TourismCustomerArguments(
            args!.searchArguments, args!.schedule, args!.wagon, newCust));

    return [false, ""];
  }
}
