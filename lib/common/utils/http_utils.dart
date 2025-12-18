import 'package:dio/dio.dart';
import 'package:radio_umsu/common/values/constants.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;
  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.serverApiUrlRadio,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {},
      contentType: "application/json; charset=UTF-8",
      responseType: ResponseType.json,
      // validateStatus: (status) => true,
      validateStatus: (status) {
        return status != null && status < 400;
      },
    );
    dio = Dio(options);

    // 🔹 Tambahkan interceptor logging
    // dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //     error: true,
    //     logPrint: (obj) => print("📡 [DIO LOG] $obj"), // Biar gampang dibaca
    //   ),
    // );
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? customUrl,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();

    if (authorization.isNotEmpty) {
      requestOptions.headers!.addAll(authorization);
    }

    final url = customUrl != null ? "$customUrl$path" : path;

    var response = await dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );

    return response.data;
  }

  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? customUrl,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();

    if (authorization.isNotEmpty) {
      requestOptions.headers!.addAll(authorization);
    }

    final url = customUrl != null ? "$customUrl$path" : path;

    var response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: requestOptions,
    );

    return response.data;
  }

  Map<String, dynamic> getAuthorizationHeader() {
    var headers = <String, dynamic>{};

    // var accessToken = AppConstants.tokenAuth;

    // if (accessToken.isNotEmpty) {
    //   headers['Authorization'] = "Bearer $accessToken";
    // }
    headers['x-api-key'] = AppConstants.apiKey;
    headers['x-secret-key'] = AppConstants.secretKey;
    return headers;
  }

  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();

    if (authorization.isNotEmpty) {
      requestOptions.headers!.addAll(authorization);
    }

    final response = await dio.delete(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
    );

    return response.data;
  }
}
