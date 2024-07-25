import 'package:get/get.dart';

/// use with an Route enum
abstract class GetPageRouteBuilder {
  String getRouteName();
  GetPage buildPage();
}

extension GetInterfaceX on GetInterface {
  Future<T?>? toRoute<T>(
    GetPageRouteBuilder builder, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return toNamed(builder.getRouteName(),
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }
}
