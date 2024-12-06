import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String idCategory) {
    return BaseNetwork.get("filter.php?c=$idCategory");
  }

  Future<Map<String, dynamic>> loadDetail(String idMeals) {
    return BaseNetwork.get("lookup.php?i=$idMeals");
  }
}
