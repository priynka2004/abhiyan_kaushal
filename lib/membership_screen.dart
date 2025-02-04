import 'package:abhiyan_kaushal/referral_screen.dart';
import 'package:flutter/material.dart';
import 'package:abhiyan_kaushal/api_service/membership_service.dart';
import 'package:abhiyan_kaushal/model/mebership_model.dart';
import 'package:abhiyan_kaushal/getepay/getepay_service.dart';
import 'package:abhiyan_kaushal/getepay/payment_web_view.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pg_sdk_kit/bin/bloc/pg_bloc.dart';
import 'package:pg_sdk_kit/bin/model/pg_invoice_response.dart';
import 'package:pg_sdk_kit/bin/networking/api_url.dart';
import 'package:pg_sdk_kit/pg_kit.dart';
import 'package:translator/translator.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  late Future<List<Membership>> _membershipFuture;
  int _selectedPlan = 0;
  final GetePayService _getePayService = GetePayService();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _membershipFuture = MembershipService().fetchMemberships();
  }

  Future<void> _handlePayment() async {
    setState(() => _isProcessing = true);

    try {
      final response = await _getePayService.generateInvoice(
        orderId: "ORDER98765",
        amount: 499.00,
        customerName: "Priyanka Sheoran",
        customerEmail: "priynka.sheoran2004@gmail.com",
        customerPhone: "8307346914",
      );

      print("🔹 Full API Response: $response");

      if (response.containsKey('status') && response['status'] == "FAILED") {
        print("❌ Payment Failed: ${response['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Failed: ${response['message']}")),
        );
      } else if (response.containsKey('invoice_url') &&
          response['invoice_url'] != null) {
        String paymentUrl = response['invoice_url'];
        print("✅ Redirecting to Payment: $paymentUrl");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentWebView(paymentUrl: paymentUrl)),
        );
      } else {
        print("❌ Error: invoice_url not found in response");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Error: invoice_url not found in response")),
        );
      }
    } catch (e) {
      print("❌ Payment failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $e")),
      );
    }

    setState(() => _isProcessing = false);
  }

  String _translatedTitle = "Loading...";

  final translator = GoogleTranslator();

  Future<String> translateToHindi(String text) async {
    var translation = await translator.translate(text, to: 'hi');
    return translation.text;
  }

  Future<String> translateText(String text) async {
    try {
      var translation = await translator.translate(text, to: 'hi');
      return translation.text;
    } catch (e) {
      return text;
    }
  }

  Future<void> fetchAndTranslateData() async {

    String apiTitle = "Hello User";

    String hindiTitle = await translateToHindi(apiTitle);

    setState(() {
      _translatedTitle = hindiTitle;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD8DADC), width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 14),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFFDD312D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/image 1.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'assets/images/Star 8.png',
                  height: 42,
                  width: 45,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: FutureBuilder<List<Membership>>(
          future: _membershipFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No memberships available.'));
            }

            final memberships = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "सदस्यता शुल्क भुगतान पूरा करें",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                    itemCount: memberships.length,
                    itemBuilder: (context, index) {
                      final membership = memberships[index];
                      return _buildPlanOption(
                          index,
                          membership.membershipTypeName,
                          "₹${membership.memberPrice}");
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: PGKit(
                    terminalId: 'Getepay.merchant61062@icici',
                    mid: '108',
                    amount: 50,
                    name: 'Hello User',
                    mobile: 9876543210,
                    onError: (PgInvoiceResponse error) {
                      log('onError: $error');
                    },
                    onSuccess: (PgInvoiceResponse success) {
                      log('onSuccess: $success');
                    },
                    pgIv: 'hlnuyA9b4YxDq6oJSZFl8g==',
                    pgKey: 'JoYPd+qso9s7T+Ebj8pi4Wl8i+AHLv+5UNJxA3JkDgY=',
                    test: true,
                    // for test use false for production use true
                    txnType: 'single',
                    udf4: '#00003',
                    udf5: '3',
                    udf6: '1',
                    udf7: '',
                    udf8: '',
                    udf9: '',
                    callbackUrl: 'https://nashamukti.bonanso.com/save/payment/',
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF0500),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  bottom: 16,
                                  left: 100,
                                  right: 100,
                                ),
                                child: Text(
                                  "Pay Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return const PaymentScreen();
                  //     }));
                  //   },
                  //   //_handlePayment,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color(0xFFFF0500),
                  //     padding: const EdgeInsets.symmetric(vertical: 16.0),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8)),
                  //   ),
                  //   child: _isProcessing
                  //       ? const CircularProgressIndicator(color: Colors.white)
                  //       : const Text('Proceed to pay',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.white)),
                  // ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlanOption(int index, String title, String price) {
    return FutureBuilder(
      future: translateText(title), // API से आया डेटा हिंदी में ट्रांसलेट होगा
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(); // लोडिंग के दौरान दिखाने के लिए
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: InkWell(
            onTap: () => setState(() => _selectedPlan = index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedPlan == index ? Colors.black : Colors.grey.shade300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      snapshot.data ?? title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  //     "mid": "108",
//     "amount": "3",
//     "merchantTransactionId": "#00003",
//     "transactionDate": "2025-01-29 09:31:10",
//     "terminalId": "Getepay.merchant61062@icici",
//     "udf1": "9090909091",
//     "udf2": "cchavan98@gmail.com",
//     "udf3": "Chandrakant Chavan",
//     "udf4": "#00003",
//     "udf5": "3",
//     "udf6": "1",
//     "udf7": "",
//     "udf8": "",
//     "udf9": "",
//     "udf10": "",
//     "ru": "",
//     "callbackUrl": "",
//     "currency": "INR",
//     "paymentMode": "ALL",
//     "bankId": "",
//     "txnType": "single",
//     "productType": "IPG",
//     "txnNote": "Order for Self scheduled date on 2025-01-29 10:00:00",
//     "vpa": "Getepay.merchant61062@icici"

//	  public static String iv ="hlnuyA9b4YxDq6oJSZFl8g==";
//	   public static String key ="JoYPd+qso9s7T+Ebj8pi4Wl8i+AHLv+5UNJxA3JkDgY=";
//	   public static  String mid = "108";
//	   public static String terminalId = "Getepay.merchant61062@icici";

  // invoiceapi.setMid(mid);
  // invoiceapi.setAmount("1");
  // invoiceapi.setMerchantTransactionID(" 1705060373101422");
  // invoiceapi.setTerminalID(terminalId);
  // invoiceapi.setTransactionDate("Mon Feb 27 11:02:35 IST 2023");
  // invoiceapi.setUdf1("7297888568");
  // invoiceapi.setUdf2("vijay.r@mygetepay.com");
  // invoiceapi.setUdf3("ROCK");
  // invoiceapi.setUdf4("14008|254819|2000");
  // invoiceapi.setUdf5("");
  // invoiceapi.setUdf6("");
  // invoiceapi.setUdf7("200000023");
  // invoiceapi.setUdf8("Optional");
  // invoiceapi.setUdf9("Optional");
  // invoiceapi.setUdf10("Optional");
  // invoiceapi.setRu("https://pay1.getepay.in:8443/getepayPortal/pg/pgPaymentResponse");
  // invoiceapi.setCallbackUrl("https://webhook.site/8b78be38-b691-46ca-ac8a-3857a98d4732");
  // invoiceapi.setCurrency("INR");
  // invoiceapi.setPaymentMode("ALL");
  // invoiceapi.setBankId("");
  // invoiceapi.setTxnType("single");
  // invoiceapi.setProductType("IPG");
  // invoiceapi.setTxnNote("Colony world Txn");
  // invoiceapi.setVpa(terminalId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF0500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PGKit(
        terminalId: 'Getepay.merchant61062@icici',
        mid: '108',
        amount: 50,
        name: 'Hello User',
        mobile: 9876543210,
        onError: (PgInvoiceResponse error) {
          log('onError: $error');
        },
        onSuccess: (PgInvoiceResponse success) {
          log('onSuccess: $success');
        },
        pgIv: 'hlnuyA9b4YxDq6oJSZFl8g==',
        pgKey: 'JoYPd+qso9s7T+Ebj8pi4Wl8i+AHLv+5UNJxA3JkDgY=',
        test: true,
        // for test use false for production use true
        txnType: 'single',
        udf4: '#00003',
        udf5: '3',
        udf6: '1',
        udf7: '',
        udf8: '',
        udf9: '',
        callbackUrl: 'https://nashamukti.bonanso.com/save/payment/',
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0500),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 100,
                      right: 100,
                    ),
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
