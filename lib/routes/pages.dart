import 'package:get/get.dart';
import 'package:infinite_scroll_search/page/favorite/favorite_binding.dart';
import 'package:infinite_scroll_search/page/favorite/favorite_page.dart';
import 'package:infinite_scroll_search/page/product/product_binding.dart';
import 'package:infinite_scroll_search/page/product/product_page.dart';

part 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.PRODUCT,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => FavoritePage(),
      binding: FavoriteBinding(),
    ),
  ];
}
