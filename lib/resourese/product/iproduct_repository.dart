import 'package:get/get_connect/http/src/response/response.dart';
import 'package:infinite_scroll_search/resourese/ibase_repository.dart';

abstract class IProductRepository extends IBaseRepository {
  Future<Response> getListData({required int page, required int limit});
  Future<Response> searchProduct(String query);
}
