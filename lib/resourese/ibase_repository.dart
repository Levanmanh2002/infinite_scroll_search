import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:infinite_scroll_search/utils/app_constants.dart';
import 'package:infinite_scroll_search/utils/dialog_util.dart';
import 'package:http/http.dart' as http;

class IBaseRepository {
  final int timeoutInSeconds = 60;

  void handleError(error) {
    print(error);
    if (error.osError != null) {
      final osError = error.osError;
      if (osError.errorCode == 101) {
        DialogUtils.showInfoErrorDialog(content: error.message);
      }
    }
  }

  getAuthorizationHeader() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future<Response> clientGetData(String uri, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> Get API Call: $uri\nHeader: ${getAuthorizationHeader()}');
      http.Response response = await http
          .get(
            Uri.parse(AppConstants.baseUrl + uri),
            headers: headers ?? getAuthorizationHeader(),
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> Get API Error: $e');
      rethrow;
    }
  }

  Future<Response> clientPostData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      debugPrint('====> Post API Call: $uri\nHeader: ${getAuthorizationHeader()}');
      debugPrint('====> Post API Body: $body');
      http.Response response = await http
          .post(
            Uri.parse(AppConstants.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? getAuthorizationHeader(),
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> Post API Error: $e');
      rethrow;
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    debugPrint('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    return response0;
  }
}
