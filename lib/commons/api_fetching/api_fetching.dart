import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shooe_pos/commons/api_fetching/base_response.dart';
import 'package:shooe_pos/commons/constants.dart';
import 'package:shooe_pos/commons/utils/log_utils.dart';

const canceledRequestMessage = "Dibatalkan";

class APIFetching {
  static Future<void> fetch(
    BuildContext context,
    String endpointPath, {
    Map? params,
    CancelToken? cancelToken,
    required Function(BaseResponse response) onSucccess,
    required Function(String error) onFailure,
  }) async {
    final dio = Dio();
    final parameters = params ?? {};
    final endpoint = ShooeHost + endpointPath;

    try {
      if (kDebugMode) {
        print("REQUEST from $endpoint: \n\n\n\n");
        print(parameters);
      }

      final result = await dio.post(
        endpoint,
        data: parameters,
        cancelToken: cancelToken,
        options: Options(validateStatus: (status) => (status ?? 0) < 999),
      );

      if (kDebugMode) {
        print("RESPONSE from $endpoint: \n\n\n\n");
        print(result.data);
      }

      final response = BaseResponse.fromJson(result.data);
      if (response.isSuccess) {
        onSucccess(response);
      } else {
        // TBD: Error Check
      }
    } catch (e) {
      LogUtils.error(
          "API Error ($endpoint)\n\nParams:\n$parameters\n\nERROR: $e");

      onFailure(e.toString());

      if (e is DioException) {
        onFailure(e.type == DioExceptionType.cancel
            ? canceledRequestMessage
            : e.type == DioExceptionType.connectionTimeout ||
                    e.type == DioExceptionType.receiveTimeout
                ? "Mohon cek jaringan kamu dan coba lagi."
                : "Sedang ada masalah pada server kami, cobalah beberapa saat lagi");
      } else {
        onFailure(e.toString());
      }
    }
  }
}
