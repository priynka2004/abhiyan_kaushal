import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'network_exception.dart';

class HttpClient {
  static HttpClient? _instance;
  final _connectivity = Connectivity();

  HttpClient._();

  factory HttpClient.instance() {
    if (_instance == null) {
      return HttpClient._();
    } else {
      return _instance!;
    }
  }

  Future<Map<String, dynamic>> get(
      {required String url, Map<String, dynamic>? parameters}) async {
    try {
      await _checkInternet();
      log('===================================================');
      String param = _makeParameter(parameters);
      log('url: $url$param');

      Uri uri = Uri.parse('$url$param');
      var response = await http.get(uri, headers: _makeHeader());

      if (response.statusCode == 200) {
        log('response(${response.statusCode}: ${response.body}');
        log('===================================================');
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        // _checkAfterResponse(jsonResponse);

        return jsonResponse;
      }
      throw NetworkException(
          message: 'Something went wrong', code: response.statusCode);
    } on NetworkException catch (e) {
      log('Network exception(${e.code}): ${e.message}');
      log('===================================================');
      rethrow;
    } on InternetException catch (e) {
      log('Internet exception: ${e.message}');
      log('===================================================');
      rethrow;
    } catch (e) {
      log('error: ${e.toString()}');
      log('===================================================');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      {required String url,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? body}) async {
    try {
      await _checkInternet();
      log('===================================================');
      String param = _makeParameter(parameters);
      log('url: $url$param');
      log('body: ${jsonEncode(body)}');
      Uri uri = Uri.parse('$url$param');
      var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: _makeHeader(),
      );

      if (response.statusCode == 200) {
        log('response(${response.statusCode}: ${response.body}');
        log('===================================================');

        Map<String, dynamic> jsonResponse = json.decode(response.body);
        // _checkAfterResponse(jsonResponse);

        return jsonResponse;
      }
      throw NetworkException(
          message: 'Something went wrong', code: response.statusCode);
    } on NetworkException catch (e) {
      log('Network exception(${e.code}): ${e.message}');
      log('===================================================');
      // _checkAfterResponse({'status': e.code});
      rethrow;
    } on InternetException catch (e) {
      log('Internet exception: ${e.message}');
      log('===================================================');
      rethrow;
    } catch (e) {
      log('error (${e.runtimeType}: ${e.toString()}');
      log('===================================================');
      rethrow;
    }
  }

  Map<String, String> _makeHeader() {
    // final context = NavigationService.navigatorKey.currentContext;
    var model = null;
    var header;

    if (model != null) {
      final credential = '${model.username}:${model.token}';
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encoded = stringToBase64.encode(credential);

      header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'token': encoded,
      };
      // log('token from: ${stringToBase64.decode(credential)}');
    } else {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    }

    log('header: $header');
    return header;
  }

  String _makeParameter(Map<String, dynamic>? param) {
    if (param == null) {
      return '';
    } else {
      String strParam = '';
      for (String key in param.keys) {
        if (strParam.isEmpty) {
          strParam = '?$key=${param[key]}';
        } else {
          strParam = '&$key=${param[key]}';
        }
      }
      return strParam;
    }
  }

  // void _checkAfterResponse(Map<String, dynamic> response) {
  //   log('_checkAfterResponse ${response['status']}');
  //
  //   BuildContext? context = NavigationService.navigatorKey.currentContext;
  //
  //   if (context != null) {
  //     if (response['status'] == 401 || response['status'] == 103) {
  //       CustomDialog.show(
  //         context: context,
  //         title: 'Attention',
  //         content: 'Sign in again please',
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               HiveService.clear();
  //               context
  //                   .read<AppBloc>()
  //                   .add(const AppEvent.updateLoginResponse(null));
  //               Navigator.pushNamedAndRemoveUntil(
  //                 context,
  //                 LoginScreen.route,
  //                 (route) => false,
  //               );
  //             },
  //             child: Text(
  //               'Ok',
  //               style: TextStyle(
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     }
  //   }
  // }

  Future<void> _checkInternet() async {
    final connectivityResult = await (_connectivity.checkConnectivity());
    const String message = 'Internet is not working';
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (kIsWeb) {
        // try {
        //   var result = await http.get(Uri.parse('www.google.com'));
        //   if (result.statusCode != 200) {
        //     throw InternetException(message: message);
        //   }
        // } catch (e) {
        //   throw InternetException(message: message);
        // }
      } else {
        try {
          final result = await InternetAddress.lookup('www.google.com');
          if (result.isEmpty && result[0].rawAddress.isEmpty) {
            throw InternetException(message: message);
          }
        } on SocketException catch (_) {
          throw InternetException(message: message);
        }
      }
    } else {
      throw InternetException(message: message);
    }
  }
}
