import 'dart:convert';
import 'dart:io';

import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SearchTicketCaches {
  static const int _maxList = 6;
  static const String _fileName = "search_histories.txt";

  SearchTicketCaches._privateConstructor();
  static final SearchTicketCaches _instance = SearchTicketCaches
      ._privateConstructor();

  static SearchTicketCaches get instance => _instance;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  String digest(SearchTicketArguments arg1){
    return "${arg1.from?.code}-${arg1.to?.code}-${DateFormat("ddMMyyyy").format(arg1.fromDate!)}";
  }

  bool equals(SearchTicketArguments arg1, SearchTicketArguments arg2){
    return digest(arg1) == digest(arg2);
  }

  Future<void> add(SearchTicketArguments booking) async {
    var theBookings = await getBookings();
    var alreadyExists = theBookings.any((element) => equals(booking, element));
    if(alreadyExists) {
      return;
    }

    if (theBookings.length == _maxList) {
      theBookings.removeLast();
    }
    theBookings.add(booking);

    final file = await _localFile;
    // Write the file
     await file.writeAsString(jsonEncode(SearchTicketArguments.toJsonList(theBookings)));
  }

  Future<List<SearchTicketArguments>> getBookings() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      if(contents == ""){
        return [];
      }

      var json = jsonDecode(contents);
      return (json is List<dynamic>) ?
      SearchTicketArguments.listFromJson(json) : [];
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }
}