import 'package:get/get.dart';
import 'package:infinite_scroll_search/page/product/product_controller.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProductController(
        productRepository: Get.find(),
      ),
    );
  }
}
