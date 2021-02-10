import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pivotino_flutter_app/const/url.dart';
import 'package:pivotino_flutter_app/services/storage.dart';

final SecureStorage secureStorage = SecureStorage();

Future<http.Response> getInstanceData({
  @required String loginEmail,
}) async {
  // request params
  var params = {'login': loginEmail};

  // prepare request url
  var url = Uri.http(pivotinoUrl, '/flutter/instance/get', params);

  // call the request and return the response
  final instanceResponse = await http.get(url);

  return instanceResponse;
}

Future<http.Response> forgotPassword({
  @required String email,
}) async {
  // request params
  var params = {'email': email};

  // prepare request url
  var url = Uri.http(pivotinoUrl, '/flutter/forgot_password', params);

  // call the request and return the response
  final response = await http.get(url);

  return response;
}

Future<void> getAuthenticationToken() async {
  // get login credentials from secured storage
  final String instanceUrl = await secureStorage.readSecureData('instance_url');
  final String login = await secureStorage.readSecureData('login');
  final String password = await secureStorage.readSecureData('password');
  final String dbName = await secureStorage.readSecureData('db_name');

  // map the request parameters
  var tokenParameters = {
    'login': login,
    'password': password,
    'db': dbName,
  };

  // prepare the request url
  var tokenUrl = Uri.https(
    instanceUrl.replaceAll("https://", ""),
    '/api/auth/token',
    tokenParameters,
  );

  // call the request and get the response
  var tokenResponse = await http.get(tokenUrl);

  // store the token if the request is successfully called
  if (tokenResponse.statusCode == 200) {
    var tokenBody = jsonDecode(tokenResponse.body);
    secureStorage.writeSecureData('token', tokenBody['access_token']);
  } else {
    throw Exception("Failed to get authentication token !!!");
  }
}

Future<http.Response> postData({
  @required String model,
  @required Object object,
}) async {
  // get instance url from secured storage
  final String instanceUrl = await secureStorage.readSecureData('instance_url');

  // prepare the request url and request body
  final responseUrl = Uri.https(
    instanceUrl.replaceAll("https://", ""),
    '/flutter/api/' + model,
  );
  var responseBody = {
    "method": "POST",
    "post_data": jsonEncode(object),
  };

  // call POST request and get the response of the request
  var response = await http.post(
    responseUrl,
    headers: {"access-token": await secureStorage.readSecureData('token')},
    body: responseBody,
  );

  if (response.statusCode == 444) {
    // status code 444 = token expired, so get token again
    await getAuthenticationToken();

    response = await http.post(
      responseUrl,
      headers: {"access-token": await secureStorage.readSecureData('token')},
      body: responseBody,
    );
  }

  return response;
}

Future<http.Response> getData({
  @required String model,
  List fields,
  String domain,
  int limit,
  int offset,
  String order,
}) async {
  // get instance url from secured storage
  final String instanceUrl = await secureStorage.readSecureData('instance_url');
  print('Get with token ---> ${await secureStorage.readSecureData('token')}');

  // prepare the request url and request body
  final responseUrl = Uri.https(
    instanceUrl.replaceAll("https://", ""),
    '/flutter/api/' + model,
  );
  var responseBody = {
    "method": "GET",
    "fields": jsonEncode(fields),
  };
  if (domain != null) {
    responseBody["domain"] = domain;
  }
  if (limit != null) {
    responseBody["limit"] = limit.toString();
  }
  if (offset != null) {
    responseBody["offset"] = offset.toString();
  }
  if (order != null) {
    responseBody["order"] = order;
  }

  // call POST request and get the response of the request
  var response = await http.post(
    responseUrl,
    headers: {"access-token": await secureStorage.readSecureData('token')},
    body: responseBody,
  );

  if (response.statusCode == 444) {
    // status code 444 = token expired, so get token again
    await getAuthenticationToken();

    response = await http.post(
      responseUrl,
      headers: {"access-token": await secureStorage.readSecureData('token')},
      body: responseBody,
    );
  }

  return response;
}

Future<http.Response> writeData({
  @required String model,
  @required int id,
  @required Object object,
}) async {
  // get instance url from secured storage
  final String instanceUrl = await secureStorage.readSecureData('instance_url');

  // prepare the request url and request body
  final responseUrl = Uri.https(
    instanceUrl.replaceAll("https://", ""),
    '/flutter/api/' + model + '/' + id.toString(),
  );
  var responseBody = {
    "method": "WRITE",
    "write_data": jsonEncode(object),
  };

  // call POST request and get the response of the request
  var response = await http.post(
    responseUrl,
    headers: {"access-token": await secureStorage.readSecureData('token')},
    body: responseBody,
  );

  if (response.statusCode == 444) {
    // status code 444 = token expired, so get token again
    await getAuthenticationToken();

    response = await http.post(
      responseUrl,
      headers: {"access-token": await secureStorage.readSecureData('token')},
      body: responseBody,
    );
  }

  return response;
}

Future<http.Response> unlinkData({
  @required String model,
  @required int id,
}) async {
  // get instance url from secured storage
  final String instanceUrl = await secureStorage.readSecureData('instance_url');

  // prepare the request url
  final responseUrl = Uri.https(
    instanceUrl.replaceAll("https://", ""),
    '/api/' + model + '/' + id.toString(),
  );

  // call DELETE request and get the response
  var response = await http.delete(
    responseUrl,
    headers: {"access-token": await secureStorage.readSecureData('token')},
  );

  if (response.statusCode == 444) {
    // status code 444 = token expired, so get token again
    await getAuthenticationToken();

    response = await http.delete(
      responseUrl,
      headers: {"access-token": await secureStorage.readSecureData('token')},
    );
  }

  return response;
}
