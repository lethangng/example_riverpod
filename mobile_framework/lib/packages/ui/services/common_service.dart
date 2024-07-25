import 'package:get/get.dart';

abstract class CommonService extends GetxService {
  Future<void> start();

  Future<void> close();
}
