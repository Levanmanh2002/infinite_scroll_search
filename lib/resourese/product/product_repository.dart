import 'package:get/get_connect/http/src/response/response.dart';
import 'package:infinite_scroll_search/resourese/product/iproduct_repository.dart';
import 'package:infinite_scroll_search/utils/app_constants.dart';

class ProductRepository extends IProductRepository {
  @override
  Future<Response> getListData({required int page, required int limit}) {
    try {
      final number = (page + 1) * limit;

      final result = clientGetData('${AppConstants.product}?limit=$number');

      return result;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }

  @override
  Future<Response> searchProduct(String query) {
    try {
      final result = clientGetData(AppConstants.searchProduct + query);

      return result;
    } catch (error) {
      handleError(error);
      rethrow;
    }
  }
}
