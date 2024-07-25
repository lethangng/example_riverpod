import 'package:dio/dio.dart';

abstract interface class ApiRoutesBuilder {
  String buildRoutes();

  dynamic buildBody();

  Map<String, dynamic>? buildParams();

  Options? buildOptions();
}
