import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_search/helper/db_helper.dart';
import 'package:infinite_scroll_search/models/product_models.dart';
import 'package:infinite_scroll_search/resourese/product/iproduct_repository.dart';

class ProductController extends GetxController {
  final IProductRepository productRepository;

  ProductController({required this.productRepository});

  final TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;
  var isLoadingSearch = false.obs;

  var isConnected = true.obs;

  final productList = Rx<List<ProductModels>?>(null);
  RxList<ProductModels> searchProductList = <ProductModels>[].obs;

  var query = ''.obs;

  int page = 0;
  int limit = 20;

  RxMap<int, bool> favorites = <int, bool>{}.obs;
  bool isFavorite(int id) => favorites[id] ?? false;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
    loadFavorites();
    debounce(query, (_) => searchProduct(), time: const Duration(milliseconds: 500));
  }

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      final response = await productRepository.getListData(page: page, limit: limit);

      if (response.statusCode == 200) {
        final List<ProductModels> products = (response.body['products'] as List)
            .map(
              (productJson) => ProductModels.fromJson(productJson),
            )
            .toList();

        productList.value = products;
      }
    } catch (e) {
      if (e is SocketException) {
        isConnected.value = false;
      } else {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFavorites() async {
    final favoriteProducts = await DBHelper.getProducts();
    for (var product in favoriteProducts) {
      favorites[product.id!] = true;
    }
  }

  void searchProduct() async {
    if (query.value.isEmpty) return;

    try {
      isLoadingSearch.value = true;

      final response = await productRepository.searchProduct(query.value);

      if (response.statusCode == 200) {
        final List<ProductModels> products = (response.body['products'] as List)
            .map(
              (productJson) => ProductModels.fromJson(productJson),
            )
            .toList();

        searchProductList.value = products;
      }
    } catch (e) {
      if (e is SocketException) {
        isConnected.value = false;
      } else {
        print(e);
      }
    } finally {
      isLoadingSearch.value = false;
    }
  }

  Future<bool> onLoadMore() async {
    final result = await productRepository.getListData(page: page, limit: limit);

    final List<ProductModels> products =
        (result.body['products'] as List).map((productJson) => ProductModels.fromJson(productJson)).toList();

    if (products.length == productList.value?.length) false;
    page += 1;

    productList.value = products;

    if (products.length < limit) return false;
    return true;
  }

  void toggleFavorite(ProductModels product) async {
    bool currentStatus = favorites[product.id!] ?? false;
    bool newStatus = !currentStatus;
    favorites[product.id!] = newStatus;

    if (newStatus) {
      await DBHelper.insertProduct(product);
    } else {
      await DBHelper.deleteProduct(product.id!);
    }

    update();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
