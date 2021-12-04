import 'package:dio/dio.dart';

const baseServerUrl = 'https://flutter-assignment-api.herokuapp.com/v1/';
Dio dio = Dio(
  BaseOptions(
    baseUrl: baseServerUrl,
    connectTimeout: 20000, // 5s
    receiveTimeout: 100000, // 100s
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  ),
);
