import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../keys.dart';

const String kBaseUrl = kBASEURL;
const Map<String, dynamic> kDefaultHeaders = {
  "content-Type": "application/json"
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = kBaseUrl;
    _dio.options.headers = kDefaultHeaders;

    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data["success"],
      data: data["data"],
      message: data["message"] ?? "Unexpected Error",
    );
  }
}
