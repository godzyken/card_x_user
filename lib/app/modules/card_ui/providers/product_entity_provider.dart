import 'package:get/get.dart';

import '../product_entity_model.dart';

class ProductEntityProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ProductEntity.fromJson(map);
      if (map is List)
        return map.map((item) => ProductEntity.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ProductEntity?> getProductEntity(int id) async {
    final response = await get('productentity/$id');
    return response.body;
  }

  Future<Response<ProductEntity>> postProductEntity(
          ProductEntity productentity) async =>
      await post('productentity', productentity);
  Future<Response> deleteProductEntity(int id) async =>
      await delete('productentity/$id');
}
