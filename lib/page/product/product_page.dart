// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_search/main.dart';
import 'package:infinite_scroll_search/models/product_models.dart';
import 'package:infinite_scroll_search/page/product/product_controller.dart';
import 'package:infinite_scroll_search/page/product/widget/item_data_widget.dart';
import 'package:infinite_scroll_search/routes/pages.dart';
import 'package:infinite_scroll_search/theme/style/style_theme.dart';
import 'package:infinite_scroll_search/widget/load_more_list_vertical_view.dart';
import 'package:infinite_scroll_search/widget/reponsive/extension.dart';

class ProductPage extends GetWidget<ProductController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products List', style: StyleThemeData.size16Weight600()),
          centerTitle: true,
          actions: [
            Padding(
              padding: padding(horizontal: 12),
              child: IconButton(
                onPressed: () => Get.toNamed(Routes.FAVORITE),
                icon: Icon(Icons.favorite, color: appTheme.errorColor),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: padding(all: 16),
          child: Obx(
            () => (!controller.isConnected.value)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: 50, color: appTheme.errorColor),
                        SizedBox(height: 10.h),
                        Text("Không có kết nối mạng", style: StyleThemeData.size16Weight600()),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            controller.fetchProduct();
                          },
                          child: const Text("Thử lại"),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      TextField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: controller.searchProduct,
                          ),
                        ),
                        onChanged: (value) {
                          controller.query.value = value;
                          if (value.isNotEmpty) {
                            controller.isLoadingSearch.value = true;
                          } else {
                            controller.isLoadingSearch.value = false;
                          }
                        },
                      ),
                      SizedBox(height: 12.h),
                      if (controller.query.value.isNotEmpty && controller.searchProductList.isNotEmpty)
                        Obx(() {
                          if (controller.isLoadingSearch.value) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            var search = controller.searchProductList;
                            if (search.isEmpty) {
                              return Center(
                                child: Text(
                                  'No products found',
                                  style: StyleThemeData.size16Weight600(),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: search.map((e) {
                                      return itemDataWidget(
                                        e,
                                        onFavoriteToggle: () => controller.toggleFavorite(e),
                                        isFavorite: controller.isFavorite(e.id!),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }
                          }
                        })
                      else
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            var product = controller.productList.value;
                            if (product == null) {
                              return Center(
                                child: Text(
                                  'No products available',
                                  style: StyleThemeData.size16Weight600(),
                                ),
                              );
                            } else {
                              return Expanded(
                                child: LoadMoreListVerticalItem<ProductModels>(
                                  items: product,
                                  loadMore: controller.onLoadMore,
                                  lineItemCount: 1,
                                  viewPadding: padding(),
                                  divider: SizedBox(height: 8.h),
                                  itemBuilder: (index, item) => Obx(
                                    () => itemDataWidget(
                                      item,
                                      onFavoriteToggle: () => controller.toggleFavorite(item),
                                      isFavorite: controller.isFavorite(item.id!),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        }),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
