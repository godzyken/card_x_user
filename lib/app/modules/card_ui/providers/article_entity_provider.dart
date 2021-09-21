import 'package:get/get.dart';

import '../models/article_entity_model.dart';

class ArticleEntityProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ArticleEntity.fromJson(map);
      if (map is List)
        return map.map((item) => ArticleEntity.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ArticleEntity?> getArticleEntity(int id) async {
    final response = await get('articleentity/$id');
    return response.body;
  }

  Future<Response<ArticleEntity>> postArticleEntity(
          ArticleEntity articleentity) async =>
      await post('articleentity', articleentity);
  Future<Response> deleteArticleEntity(int id) async =>
      await delete('articleentity/$id');
}
