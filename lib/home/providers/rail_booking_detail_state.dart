import 'dart:convert';
import 'dart:io';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/models/transaction.dart';
import 'package:kai_wisata/data/config.dart';
import 'package:kai_wisata/home/services/booking_service.dart';
import 'package:kai_wisata/kai_reguler/models/rail_booking_info.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:kai_wisata/data/config.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:kai_wisata/pdf_viewer_arguments.dart';
import 'package:kai_wisata/pdf_viewer_page.dart';

class RailBookingDetailState with ChangeNotifier {
  BuildContext? context;
  GlobalKey<ScaffoldState>? key;
  bool _disposed = false;

  void initState(
    BuildContext ctx,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    context = ctx;
    key = scaffoldKey;
    String? filename;
  }

  void onBackButton() {
    Navigator.pop(context!);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  printETiket(String? bookingCode, String savePath) async {
    try {
      var baseUrl = Config().baseUrl;
      Uri endPoint =
          Uri.parse(baseUrl + '/api/train/e_ticket?booking_code=$bookingCode');
      print(endPoint);
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      // Map<String, dynamic> params = {"booking_code": bookingCode};

      var response = await http.get(endPoint);
      final bytes = response.bodyBytes;
      return _storeFile(bytes, savePath);
    } catch (e) {
      return false;
    }
  }

  Future<void> _storeFile(List<int> bytes, String savePath) async {
    // const filename = "tiket2.pdf";
    final file = File('$savePath');
    print('$savePath');
    await file.writeAsBytes(bytes, flush: true);
    String fileName = "$savePath";

    // Navigator.pushNamed(context!, PdfViewerPage.routeName,
    //     arguments: PdfViewerArguments(fileName));
  }

  printExTiket(String? bookingCode, String savePath) async {
    try {
      // String etiket = await BookingServices.printETicket(bookingCode!);
      var baseUrl = Config().baseUrl;
      String endPoint = baseUrl + '/api/train/e_ticket';

      Map<String, dynamic> data = {"booking_code": bookingCode};

      var dio = Dio();

      Response response = await dio.post(endPoint,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
          data: jsonEncode(data));

      print(savePath);
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();

      return savePath;
    } catch (e) {
      print(e);
      print('END ERROR');
    }
  }
}
