import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;


class PaymentWebView extends StatefulWidget {
  final String paymentUrl;

  PaymentWebView({required this.paymentUrl});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}



class EncryptionHelper {
  static const String keyString = "JoYPd+qso9s7T+Ebj8pi4Wl8i+AHLv+5UNJxA3JkDgY=";
  static const String ivString = "hlnuyA9b4YxDq6oJSZFl8g==";

  static String encryptData(String plainText) {
    final key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }
}



class EncryptionService {
  static const String keyString = "JoYPd+qso9s7T+Ebj8pi4Wl8i+AHLv+5UNJxA3JkDgY=";
  static const String ivString = "hlnuyA9b4YxDq6oJSZFl8g==";

  static String encryptData(String plainText) {
    final key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptData(String encryptedText) {
    try {
      final key = encrypt.Key.fromBase64(keyString);
      final iv = encrypt.IV.fromBase64(ivString);
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

      final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
      return decrypted;
    } catch (e) {
      return "Decryption Error: $e";
    }
  }
}
