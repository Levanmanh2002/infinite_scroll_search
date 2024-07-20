import 'package:flutter/material.dart';
import 'package:infinite_scroll_search/main.dart';
import 'package:infinite_scroll_search/models/product_models.dart';
import 'package:infinite_scroll_search/theme/style/style_theme.dart';
import 'package:infinite_scroll_search/widget/custom_image_widget.dart';
import 'package:infinite_scroll_search/widget/reponsive/extension.dart';

Widget itemDataWidget(ProductModels product, {required void Function() onFavoriteToggle, required bool isFavorite}) {
  return Card(
    elevation: 4,
    child: ListTile(
      contentPadding: padding(all: 16),
      title: Text(product.title ?? 'No title', style: StyleThemeData.size16Weight600()),
      leading: CustomImageWidget(
        image: product.thumbnail.toString(),
        width: 50,
        height: 50,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description ?? 'No description',
            style: StyleThemeData.size14Weight400(color: appTheme.fadeTextColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Text(
            '${product.price}đ',
            style: StyleThemeData.size16Weight600(color: appTheme.successColor),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? appTheme.errorColor : appTheme.fadeTextColor,
        ),
        onPressed: onFavoriteToggle,
      ),
      onTap: () {},
    ),
  );
}
