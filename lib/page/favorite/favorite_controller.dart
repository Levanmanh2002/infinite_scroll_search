import 'package:get/get.dart';
import 'package:infinite_scroll_search/helper/db_helper.dart';
import 'package:infinite_scroll_search/models/product_models.dart';
import 'package:infinite_scroll_search/page/product/product_controller.dart';

class FavoriteController extends GetxController {
  var favorites = <ProductModels>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      isLoading.value = true;
      final db = await DBHelper.getProducts();

      favorites.value = db;
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite(ProductModels product) async {
    await DBHelper.deleteProduct(product.id!);
    favorites.removeWhere((p) => p.id == product.id);
    Get.find<ProductController>().favorites.remove(product.id);
  }

  bool isFavorite(int id) {
    return favorites.any((product) => product.id == id);
  }
}
