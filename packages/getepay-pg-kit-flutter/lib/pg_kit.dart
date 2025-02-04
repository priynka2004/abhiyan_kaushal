import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pg_sdk_kit/bin/bloc/pg_bloc.dart';
import 'package:pg_sdk_kit/bin/model/pg_invoice_response.dart';
import 'package:pg_sdk_kit/bin/model/pg_status_request.dart';
import 'package:pg_sdk_kit/bin/networking/api_url.dart';
import 'package:pg_sdk_kit/bin/networking/pg_constants.dart';
import 'package:pg_sdk_kit/bin/pg_web_view.dart';

class PGKit extends StatelessWidget {
  const PGKit({
    Key? key,
    required this.terminalId,
    required this.mid,
    required this.amount,
    required this.name,
    required this.mobile,
    required this.txnType,
    required this.child,
    required this.onError,
    required this.onSuccess,
    required this.pgKey,
    required this.pgIv,
    required this.test,
    this.ru,
    required this.udf4,
    required this.udf5,
    required this.udf6,
    required this.udf7,
    required this.udf8,
    required this.udf9,
    required this.callbackUrl,
  }) : super(key: key);

  final String terminalId;
  final String mid;
  final double amount;
  final String name;
  final int mobile;
  final String txnType;
  final Widget child;
  final Function(PgInvoiceResponse error) onError;
  final Function(PgInvoiceResponse success) onSuccess;
  final bool test;
  final String? ru;
  final String pgIv;
  final String pgKey;
  final String udf4;
  final String udf5;
  final String udf6;
  final String udf7;
  final String udf8;
  final String udf9;
  final String callbackUrl;

  @override
  Widget build(BuildContext context) {
    ApiUrl.kTest = test;
    kIvKey = pgIv;
    kKey = pgKey;

    return BlocProvider(
      create: (context) => PgBloc(),
      child: _PGKit(
        terminalId: terminalId,
        mid: mid,
        amount: amount,
        name: name,
        mobile: mobile,
        txnType: txnType,
        udf4: udf4,
        udf5: udf5,
        udf6: udf6,
        udf7: udf7,
        udf8: udf8,
        udf9: udf9,
        callbackUrl: callbackUrl,
        ru: ru,
        onError: onError,
        onSuccess: onSuccess,
        child: child,
      ),
    );
  }
}

class _PGKit extends StatefulWidget {
  const _PGKit({
    Key? key,
    required this.terminalId,
    required this.mid,
    required this.amount,
    required this.name,
    required this.mobile,
    required this.txnType,
    required this.udf4,
    required this.udf5,
    required this.udf6,
    required this.udf7,
    required this.udf8,
    required this.udf9,
    required this.callbackUrl,
    this.ru,
    required this.child,
    required this.onError,
    required this.onSuccess,
  }) : super(key: key);

  final String terminalId;
  final String txnType;
  final String mid;
  final double amount;
  final String name;
  final String udf4;
  final String udf5;
  final String udf6;
  final String udf7;
  final String udf8;
  final String udf9;
  final String callbackUrl;
  final String? ru;
  final int mobile;
  final Widget child;
  final Function(PgInvoiceResponse success) onError;
  final Function(PgInvoiceResponse success) onSuccess;

  @override
  State<_PGKit> createState() => _PGKitState();
}

class _PGKitState extends State<_PGKit> {
  String? _selectedOption = 'Without RU'; // Default option
  TextEditingController _ruController = TextEditingController();
  void showRUPopup(PgBloc bloc, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Option'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile<String>(
                    title: const Text('With RU'),
                    value: 'With RU',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                        // Show TextFormField if 'With RU' is selected
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Without RU'),
                    value: 'Without RU',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                        // Hide TextFormField if 'Without RU' is selected
                      });
                    },
                  ),
                  if (_selectedOption == 'With RU')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _ruController,
                        decoration: const InputDecoration(
                          labelText: 'Enter RU',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    bloc.add(PgEvent.getLink(
                      mid: widget.mid,
                      name: widget.name,
                      amount: widget.amount,
                      mobile: widget.mobile,
                      terminalId: widget.terminalId,
                      txnType: widget.txnType,
                      udf4: widget.udf4,
                      udf5: widget.udf5,
                      udf6: widget.udf6,
                      udf7: widget.udf7,
                      udf8: widget.udf8,
                      udf9: widget.udf9,
                      callbackUrl: widget.callbackUrl,
                      ru: _selectedOption == 'With RU'
                          ? _ruController.text
                          // : (widget.ru != null && widget.ru!.isNotEmpty)
                          //     ? widget.ru
                          : ApiUrl.ru,
                    )
                        // ru: (widget.ru != null && widget.ru != "") ? widget.ru! : ApiUrl.ru),
                        );
                    // You can use the selected values (_selectedOption and _textController.text) here if needed
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PgBloc, PgState>(
        builder: (context, state) {
          return state.status == PgStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () {
                    print("RU>>> >>>>   ${widget.ru}");
                    var bloc = context.read<PgBloc>();

                    // showRUPopup(bloc, context);

                      context.read<PgBloc>().add(
                PgEvent.getLink(
                    mid: widget.mid,
                    name: widget.name,
                    amount: widget.amount,
                    mobile: widget.mobile,
                    terminalId: widget.terminalId,
                    txnType: widget.txnType,
                    udf4: widget.udf4,
                    udf5: widget.udf5,
                    udf6: widget.udf6,
                    udf7: widget.udf7,
                    udf8: widget.udf8,
                    udf9: widget.udf9,
                    callbackUrl: widget.callbackUrl,
                    ru: (widget.ru != null && widget.ru != "") ? widget.ru! : ApiUrl.ru),
              );
                  },
                  child: widget.child,
                );
        },
        listener: (context, state) {
          if (state.status == PgStatus.success && state.response != null) {
            // TODO: REMOVE THIS CONDITION OF PG/PAYMENT
            late String url;
            // if (state.response!.paymentUrl.contains("pg/payment")) {
            //   url = state.response!.paymentUrl
            //       .replaceAll("pg/payment", "invoice/item_invoicePaymentPage");
            // }

            url = state.response!.paymentUrl;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PgWebView(
                  url: url,
                  pgStatusRequest: PgStatusRequest(
                    terminalId: widget.terminalId,
                    mid: widget.mid,
                    paymentId: state.response!.paymentId,
                  ),

                ),
              ),
            ).then((value) {
              if (value != null && value is PgInvoiceResponse) {
                // Successfully retrieved the response
                if (value.paymentStatus == 'SUCCESS') {
                  widget.onSuccess(value);
                } else {
                  widget.onError(value);
                }
              } else {
                widget.onError(value);
              }
            });
          }

          /*  if (state.status == PgStatus.error) {
            onError(state.error);
          }*/
        },
      ),
    );
  }
}
