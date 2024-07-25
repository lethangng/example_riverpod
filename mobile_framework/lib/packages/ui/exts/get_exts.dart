import 'package:get/get.dart';

extension GetXExts on GetInterface {
  void registerController<T>(T controller, {String? tag}) {
    Get.lazyPut(() => controller, tag: tag);
  }

  void registerPermanent<T>(T instance, {String? tag}) {
    Get.put(instance, permanent: true, tag: tag);
  }

  void register<T>(T instance, {String? tag}) {
    Get.lazyPut(() => instance, tag: tag);
  }

  void forceDelete<T>({String? tag}) {
    Get.delete<T>(force: true);
  }
}
