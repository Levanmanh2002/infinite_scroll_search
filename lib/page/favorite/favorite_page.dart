// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_search/page/favorite/favorite_controller.dart';
import 'package:infinite_scroll_search/page/product/widget/item_data_widget.dart';
import 'package:infinite_scroll_search/theme/style/style_theme.dart';

class FavoritePage extends GetWidget<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách yêu thích', style: StyleThemeData.size16Weight600()),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.favorites.isEmpty) {
          return const Center(child: Text('Không có sản phẩm yêu thích nào.'));
        } else {
          return ListView.builder(
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              final product = controller.favorites[index];
              return itemDataWidget(
                product,
                onFavoriteToggle: () => controller.toggleFavorite((product)),
                isFavorite: controller.isFavorite(product.id!),
              );
            },
          );
        }
      }),
    );
  }
}
