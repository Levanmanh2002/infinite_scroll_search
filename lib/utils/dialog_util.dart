import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_search/main.dart';
import 'package:infinite_scroll_search/theme/style/style_theme.dart';
import 'package:infinite_scroll_search/widget/reponsive/extension.dart';

class DialogUtils {
  static showInfoErrorDialog({
    String content = '',
    String? title,
    TextStyle? contentStyle,
    EdgeInsets? contentPadding,
    String? primaryText,
    String? outlineText,
    bool? barrierDismissible,
  }) async {
    return showDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: PopScope(
            canPop: false,
            child: Container(
              width: 305.w,
              decoration: BoxDecoration(
                color: appTheme.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: padding(top: 16, right: 19),
                    child: GestureDetector(onTap: Get.back, child: const Icon(Icons.close, size: 24)),
                  ),
                  SizedBox(
                    width: 305.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 32.h),
                        Padding(
                          padding: padding(horizontal: 12),
                          child: Text(
                            title ?? '',
                            style: StyleThemeData.size24Weight700(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: contentPadding ?? padding(horizontal: 24),
                          child: Text(
                            content,
                            textAlign: TextAlign.center,
                            style: contentStyle ?? StyleThemeData.size16Weight400(),
                          ),
                        ),
                        SizedBox(height: 36.h)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
