import 'package:get/get.dart';
import 'package:infinite_scroll_search/resourese/product/product_repository.dart';
import 'package:infinite_scroll_search/resourese/product/iproduct_repository.dart';

class AppService {
  static Future<void> initAppService() async {
    Get.put<IProductRepository>(ProductRepository());
  }
}
