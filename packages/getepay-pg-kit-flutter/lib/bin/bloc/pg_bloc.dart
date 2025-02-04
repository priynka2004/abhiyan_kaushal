import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:pg_sdk_kit/bin/encrypt/aes_convert.dart';
import 'package:pg_sdk_kit/bin/model/pg_invoice_response.dart';
import 'package:pg_sdk_kit/bin/model/pg_request.dart';
import 'package:pg_sdk_kit/bin/model/pg_status_request.dart';
import 'package:pg_sdk_kit/bin/networking/network_exception.dart';
import 'package:pg_sdk_kit/bin/networking/pg_constants.dart';

import '../model/Pg_link_response.dart';
import '../repo/pg_repo.dart';

part 'pg_bloc.freezed.dart';
part 'pg_event.dart';
part 'pg_state.dart';

class PgBloc extends Bloc<PgEvent, PgState> {
  PgBloc()
      : super(PgState(
          repo: PgRepo(),
        )) {
    on<_GetLink>((event, emit) async {
      try {
        emit(
          state.copyWith(status: PgStatus.loading),
        );

        if (event.terminalId.trim().isEmpty) {
          throw NetworkException(
              message: 'Please provide terminal id.', code: -1);
        }

        if (kIvKey.trim().isEmpty) {
          throw NetworkException(message: 'Please provide IV key.', code: -1);
        }

        if (kKey.trim().isEmpty) {
          throw NetworkException(message: 'Please provide key.', code: -1);
        }

        if (event.name.trim().isEmpty) {
          throw NetworkException(message: 'Please provide name.', code: -1);
        }

        if (validateMobile(event.mobile.toString())) {
          throw NetworkException(
              message: 'Please provide valid mobile number.', code: -1);
        }

        PgRequest request = PgRequest(
          amount: event.amount,
          currency: 'INR',
          merchantTransactionId: DateTime.now().millisecond,
          mid: int.parse(event.mid),
          paymentMode: 'ALL',
          productType: 'IPG',
          terminalId: event.terminalId,
          txnType: event.txnType,
          transactionDate: DateFormat('yyyy/MM/dd').format(DateTime.now()),
          udf1: event.mobile,
          udf3: event.name,
          udf4: event.udf4,
          udf5: event.udf5,
          udf6: event.udf6,
          udf7: event.udf7,
          udf8: event.udf8,
          udf9: event.udf9,
          callbackUrl: event.callbackUrl,
          ru: event.ru,
        );

        log('request: $request');

        String req = AesConvert.encryptUsingAes(
          key: kKey,
          plainText: jsonEncode(request.toJson()),
          ivKey: kIvKey,
        );

        Map<String, dynamic> res = await state.repo.getLink(request: {
          'mid': event.mid,
          'req': req,
          'terminalId': event.terminalId //'getepay.merchant59020@icici'
        });

        final decodedRes = AesConvert.decryptAes(
          // key: 'HWVLDkWv9k/3L3X94p7q4A==',
          key: kKey,
          encoded: res['response'],
          // ivKey: 'eX8bSifM18WlwG/0xF58tg==',
          ivKey: kIvKey,
        );

        log(decodedRes);

        PgLinkResponse response =
            PgLinkResponse.fromJson(json.decode(decodedRes));

        emit(
          state.copyWith(
            response: response,
            status: PgStatus.success,
          ),
        );
      } on NetworkException catch (e) {
        emit(state.copyWith(
          status: PgStatus.error,
          error: e.message,
        ));
      } on InternetException catch (e) {
        emit(state.copyWith(
          status: PgStatus.error,
          error: e.message,
        ));
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(
          status: PgStatus.error,
          error: 'Something went wrong',
        ));
      }
    });

    on<_GetInvoiceStatus>((event, emit) async {
      try {
        emit(
          state.copyWith(status: PgStatus.loading),
        );

        log('request: ${event.request.toJson()}');

        String req = AesConvert.encryptUsingAes(
          key: kKey,
          plainText: jsonEncode(event.request.toJson()),
          ivKey: kIvKey,
        );

        Map<String, dynamic> res = await state.repo.getInvoiceStatus(
          request: {
            'mid': event.request.mid,
            'req': req,
            'terminalId':
                event.request.terminalId //'getepay.merchant59020@icici'
          },
        );

        if (res['status'] == 'SUCCESS' || res['status'] == 'FAILED') {
          final decodedRes = AesConvert.decryptAes(
            key: kKey,
            encoded: res['response'],
            ivKey: kIvKey,
          );

          log(decodedRes);

          PgInvoiceResponse response =
              PgInvoiceResponse.fromJson(json.decode(decodedRes));

          if (response.paymentStatus == 'SUCCESS') {
            emit(
              state.copyWith(
                pgInvoiceResponse: response,
                status: PgStatus.success,
              ),
            );
          } else {
            emit(
              state.copyWith(
                pgInvoiceResponse:
                    response, // TODO: IMPLEMENT => response.message.
                status: PgStatus.error,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              error: 'Something went wrong, try after some time',
              status: PgStatus.error,
            ),
          );
        }
      } on NetworkException catch (e) {
        emit(state.copyWith(
          status: PgStatus.error,
          error: e.message,
        ));
      } on InternetException catch (e) {
        emit(state.copyWith(
          status: PgStatus.error,
          error: e.message,
        ));
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(
          status: PgStatus.error,
          error: 'Something went wrong',
        ));
      }
    });
  }

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return true;
    } else if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }
}
