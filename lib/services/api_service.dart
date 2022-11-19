import 'dart:convert';

import 'package:classified_app/commons/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<String> _getToken() async {
    String token = await storage.read(key: 'token') ?? '';
    print('storage token: $token');
    return token.toString();
  }

  Future<Map<String, String>> _getHeaders({bool contentType = true}) async {
    String token = await _getToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    print('contenttype: $contentType');
    contentType == true
        ? headers.addAll({'Content-Type': 'application/json'})
        : null;
    print(headers);
    print(headers.runtimeType);

    return headers;
  }

  multipartRequest(
    String enpoint,
    String method,
    String input, {
    String? filePath,
    List<String>? imageList,
  }) async {
    var requestUrl = Uri.parse("${Constants().serverUrl}$enpoint");
    var request = http.MultipartRequest(method, requestUrl);
    if (filePath != null) {
      MultipartFile image = await http.MultipartFile.fromPath(input, filePath);
      request.files.add(image);
    } else if (imageList != null && imageList.isNotEmpty) {
      for (String element in imageList) {
        MultipartFile image = await http.MultipartFile.fromPath(input, element);
        request.files.add(image);
      }
    }

    request.headers.addAll(await _getHeaders());

    var response = await request.send();
    var resp = await response.stream.bytesToString();
    var respJson = jsonDecode(resp);
    print(respJson);
    return respJson;
  }

  post(
    enpoint, {
    Object? body,
    bool contentType = true,
  }) async {
    var responseJson;
    var requestUrl = Uri.parse("${Constants().serverUrl}$enpoint");
    print(requestUrl);
    var headers = await _getHeaders(contentType: contentType);
    print(headers);
    try {
      var response = await http.post(
        requestUrl,
        headers: headers,
        body: jsonEncode(body),
      );
      print('resp no handle: ${response.body.toString()}');
      responseJson = _handleResponse(response);
      print('PostResponse: $responseJson');
    } catch (e) {
      print('error $e');
    }
    return responseJson;
  }

  get(enpoint) async {
    var responseJson;
    var requestUrl = Uri.parse("${Constants().serverUrl}$enpoint");
    try {
      var response = await http.get(requestUrl);
      responseJson = _handleResponse(response);
    } catch (e) {
      print('Error: $e');
    }
    print('post respnse: $responseJson');
    return responseJson;
  }

  patch(endpoint, body) async {
    var responseJson;
    var requestUrl = Uri.parse('${Constants().serverUrl}$endpoint');
    print(requestUrl);
    var headers = await _getHeaders();
    print(headers);
    try {
      var response = await http.patch(
        requestUrl,
        headers: headers,
        body: jsonEncode(body),
      );
      print('PatchResNohandle: ${response.body.toString()}');
      responseJson = _handleResponse(response);
      print('PatchResponseHandled: $responseJson');
    } catch (e) {
      print('erros patch: $e');
    }
    return responseJson;
  }

  delete(endpoint) async {
    var responseJson;
    var requestUrl = Uri.parse('${Constants().serverUrl}$endpoint');
    print(requestUrl);
    var headers = await _getHeaders();
    print(headers);
    try {
      var response = await http.delete(
        requestUrl,
        headers: headers,
      );
      print('PatchResNohandle: ${response.body.toString()}');
      responseJson = _handleResponse(response);
      print('PatchResponseHandled: $responseJson');
    } catch (e) {
      print('erros patch: $e');
    }
    return responseJson;
  }

  _handleSuccessResponse(http.Response response) {
    print(jsonDecode(response.body).toString());
    return jsonDecode(response.body);
  }

  _handleSucessStreamedResponse(http.StreamedResponse response) async {
    print(jsonDecode(await response.stream.bytesToString()));
    var resp = await response.stream.bytesToString();
    return jsonDecode(resp);
  }

  _handleResponse(dynamic response) {
    switch (response.statusCode) {
      case 200:
        var responseJson;
        if (response is http.Response) {
          responseJson = _handleSuccessResponse(response);
        } else if (response is http.StreamedResponse) {
          responseJson = _handleSucessStreamedResponse(response);
        }
        return responseJson;
      case 401:
        return {'message': 'Invalid request', 'status': false};
      case 403:
        return {'message': 'UnAuthorized', 'status': false};
      case 500:
        return {'message': 'Server error', 'status': false};
      default:
        return {'message': 'Unknown error', 'status': false};
    }
  }
}
