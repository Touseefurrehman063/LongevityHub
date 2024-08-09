import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:longevity_hub/data/response/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    log("GET API URL: $url");
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } catch (e) {
      log("GET API Error: $e");
    }
    log("GET API Response: $responseJson");
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    log("POST API URL: $url");
    log("POST API Data: ${jsonEncode(data)}");
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } catch (e) {
      log("POST API Error: $e");
    }
    log("POST API Response: $responseJson");
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    log("API Status Code: ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        return jsonDecode(response.body);
      default:
        log("Unhandled status code: ${response.statusCode}");
        return {
          "status": 0,
          "message": "Unhandled status code: ${response.statusCode}"
        };
    }
  }
}
