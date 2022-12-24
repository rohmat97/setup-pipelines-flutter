import 'package:kai_wisata/user/models/auth_cache.dart';

import 'data/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'kai_reguler/services/connection_error_exception.dart';

class BaseService {
  static getHttpHeader() {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var token = AuthCache.instance.get();
    if (token != "") {
      header["Authorization"] = "Bearer $token";
    }
    return header;
  }

  static String get baseUrl => Config().baseUrl;

  static get(String url) async {
    Uri endPoint = Uri.parse(baseUrl + url);
    var response = await http.get(endPoint, headers: getHttpHeader());
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ConnectionErrorException(
          'Request failed with status: ${response.statusCode}.');
    }
  }

  static getWithParams(String url, Map<String, dynamic> params) async {
    String queryString = Uri(queryParameters: params).query;
    var requestUrl = baseUrl + url + '?' + queryString; // result -
    Uri endPoint = Uri.parse(requestUrl);
    var response = await http.get(endPoint, headers: getHttpHeader());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ConnectionErrorException(
          'Request failed with status: ${response.statusCode}.');
    }
  }

  static post(url, Map<String, dynamic> params) async {
    Uri endPoint = Uri.parse(baseUrl + url);
    var response = await http.post(endPoint,
        headers: getHttpHeader(), body: jsonEncode(params));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      try {
        var data = json.decode(response.body);
        throw ConnectionErrorException(data["error"]["message"]);
      } on FormatException catch (e) {
        throw ConnectionErrorException(
            'Request failed with status: ${response.statusCode}.');
      }
    }
  }

  static postForm(url, Map<String, dynamic> params) async {
    Uri endPoint = Uri.parse(baseUrl + url);
    var headers = getHttpHeader();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    var response = await http.post(endPoint, headers: headers, body: params);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ConnectionErrorException(
          'Request failed with status: ${response.statusCode}.');
    }
  }
}
