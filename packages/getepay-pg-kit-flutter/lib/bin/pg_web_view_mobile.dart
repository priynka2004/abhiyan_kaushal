import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'PaymentBottomSheet.dart';
import 'bloc/pg_bloc.dart';
import 'model/pg_status_request.dart';



class PgWebView extends StatefulWidget {
  const PgWebView({Key? key, required this.url, required this.pgStatusRequest})
      : super(key: key);
  final String url;
  final PgStatusRequest pgStatusRequest;

  @override
  State<PgWebView> createState() => _PgWebViewState();
}

class _PgWebViewState extends State<PgWebView> {
  late final WebViewController _controller;
  final PgBloc bloc = PgBloc();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

      // Mobile-specific WebView setup
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0xffffffff))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
              log('url: $url');
              if (url.contains('pgPaymentResponse')) {
                Future.delayed(const Duration(seconds: 5), () {
                  bloc.add(PgEvent.getInvoiceStatus(request: widget.pgStatusRequest));
                });
              }
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) async {
              if (request.url.startsWith('upi:')) {
                String url = request.url;
                log('Upi link $url');
                log('Upi link end');
                if (io.Platform.isIOS) {
                  await _showPaymentOptions(url);
                } else {
                  _launchCustomScheme(url);
                }

                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));

  }

  Future<void> _launchCustomScheme(String url) async {
    log('canLaunchUrl condition check');
    try {
      Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      if (mounted) {
        _controller.loadRequest(Uri.parse(widget.url));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open any UPI application'),
          ),
        );
      }
    }
  }

  Future<void> _showPaymentOptions(String url) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PaymentBottomSheet(
          onOptionSelected: (String paymentOption) {
            String modifiedUrl;
            if (paymentOption == 'tez://upi/') {
              modifiedUrl = url.replaceFirst('upi://', 'tez://upi/');
            } else {
              modifiedUrl = url.replaceFirst('upi:', paymentOption);
            }
            log('modified url: $modifiedUrl');
            Navigator.pop(context);
            _launchCustomScheme(modifiedUrl);
          },
        );
      },
    );
  }

  void readJS() async {
    var htmlContent = await _controller.runJavaScriptReturningResult('''
        function asd() {
            var box1 = window.document.getElementById("box1").getElementsByTagName("p");
            var arr = [];
            for(i = 0; i<=box1.length -1; i++ ) {
             arr.push(box1[i].innerText);
            };
            return arr;
          };
        
        asd();
        ''');
    List str = json.decode(htmlContent.toString());
    log(str.toString());

    if (htmlContent.toString().contains('SUCCESS')) {
      log('Success');
    } else {
      log('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<PgBloc, PgState>(
          bloc: bloc,
          listener: (context, state) {
            print("STATE>STATUS MOBILE   >>>>>>   ${state.status}");
            if (state.status == PgStatus.success) {
              Navigator.pop(context, state.pgInvoiceResponse);
            }
            if (state.status == PgStatus.error) {
              Navigator.pop(context, state.pgInvoiceResponse);
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                if (!kIsWeb)
                  WebViewWidget(
                    controller: _controller,
                  ),
                if (isLoading) const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
