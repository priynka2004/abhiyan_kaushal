import 'dart:async';
import 'dart:developer';
import 'dart:html' as html; // Import 'dart:html' for web support
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
  final PgBloc bloc = PgBloc();
  bool isLoading = false;
  String paymentStatus = 'unknown';

  @override
  void initState() {
    super.initState();


    if (kIsWeb) {
      // If running on the web, open the URL in a new tab using url_launcher
      // _launchUrl('https://pay1.getepay.in:8443/getepayPortal/pg/payment?token=035510ce-2713-4de8-896c-66f0d881114b');
      // capturePostedData();
      _launchUrl(widget.url);

   /*   // Check the initial URL
      _checkCurrentUrl();
      // Listen for URL changes (e.g., back/forward navigation)
      html.window.onPopState.listen((event) {
        _checkCurrentUrl();
      });*/
    }
  }
  void capturePostedData() {
    // Access the URL query parameters
    Uri uri = Uri.parse(html.window.location.href);
    log('url---->$uri');
    String? status = uri.queryParameters['mid']; // Assuming 'status' is a parameter in the return URL


    // Handle the status or other data
    setState(() {
      paymentStatus = status ?? 'Unknown';
    });
    log('status--->$paymentStatus');
    html.window.console.log('STATUS-----> $paymentStatus');

    // Optionally, you can also handle posted data using forms or other methods
  }
  Future<void> _launchUrl(String url) async {
    try {
      log('Launching URL: $url');
      // Use url_launcher to open the URL in a new tab
      if (await canLaunch(url)) {
        await launch(url,
          forceSafariVC: true,
          forceWebView: true,
          webOnlyWindowName: '_self',); // Open in a same tab
        // webOnlyWindowName: '_blank'); // Open in a new tab

      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log('Error launching URL: $e');
    }
  }

  void _checkCurrentUrl() {
    // Get the current URL
    String currentUrl = html.window.location.href;
    log('Current URL: $currentUrl');

    // Implement your logic based on the current URL
    if (currentUrl.contains('pgPaymentResponse')) {
      // _handlePaymentSuccess();
      _showAlert(currentUrl);
    } else {
      // _showAlert(currentUrl); // Show the URL in an alert box
    }
  }
  void _handlePaymentSuccess() {
    // Perform actions after payment is confirmed
    log('Payment response received');
    bloc.add(PgEvent.getInvoiceStatus(request: widget.pgStatusRequest));

    // Optionally, you can also close the current window/tab if necessary
    if (kIsWeb) {
      html.window.close();
    }
  }

  void _handleSpecificUrlChange(String url) {
    log('Handling specific URL change: $url');
    // Implement your logic based on the URL change
    // For example, handle a payment success page
    if (url.contains('pgPaymentResponse')) {
      _handlePaymentSuccess();
    }
  }
  void _showAlert(String url) {
    // Ensure the dialog is shown after the current frame.
    Future.delayed(Duration.zero, () {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Current URL'),
              content: Text('The current URL is: $url'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<PgBloc, PgState>(
          bloc: bloc,
          listener: (context, state) {
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
                    // Initialize your WebViewWidget here for non-web platforms
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onPageFinished: (url) {
                            // _checkPaymentResponse(url);
                          },
                        ),
                      )
                      ..loadRequest(Uri.parse(widget.url)),
                  ),
                if (isLoading) const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose resources if needed
    super.dispose();
  }
}
