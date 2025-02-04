import 'dart:convert';

import 'package:crypto/crypto.dart';

class Signature {
  static String makeSignature(
      {required String password, required List<String> param}) {
    String md5Password =
        password == 'GetePay@2019' ? password : _strToMD5(password);
    String concatParam = param.join();

    return _strToHmac(md5Password: md5Password, paramString: concatParam);
    // return _strToSHA512(md5Password: md5Password, paramString: concatParam);
  }

  static String _strToMD5(String password) {
    var bytes = utf8.encode(password); // encode the string to bytes
    var md5Hash = md5.convert(bytes); // create the MD5 hash

    return md5Hash.toString();
  }

  // static String _strToSHA512(
  //     {required String md5Password, required String paramString}) {
  //   String combinedString = md5Password + paramString;
  //   // create a new SHA-512 hash object and hash the combined string
  //   var bytes = utf8.encode(combinedString);
  //   var sha512Hash = sha512.convert(bytes);
  //   log('Sign: $sha512Hash');
  //   return sha512Hash.toString();
  // }

  static String _strToHmac(
      {required String md5Password, required String paramString}) {
    var key = utf8.encode(md5Password);
    var bytes = utf8.encode(paramString);

    var hmacSha512 = Hmac(sha512, key); // HMAC-SHA256
    var digest = hmacSha512.convert(bytes);

    // log('HMAC digest as bytes: ${digest.bytes}');
    // log("HMAC digest as hex string: $digest");

    return digest.toString();
  }
}
