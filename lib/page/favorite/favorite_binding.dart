import 'package:get/get.dart';
import 'package:infinite_scroll_search/page/favorite/favorite_controller.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FavoriteController(),
    );
  }
}
