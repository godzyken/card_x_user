import 'package:get/get.dart';

import '../models/models.dart';


class PokemonTypesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Types.fromJson(map);
      if (map is List)
        return map.map((item) => Types.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Types?> getPokemonTypes(int id) async {
    final response = await get('pokemontypes/$id');
    return response.body;
  }

  Future<Response<Types>> postPokemonTypes(
          Types pokemontypes) async =>
      await post('pokemontypes', pokemontypes);
  Future<Response> deletePokemonTypes(int id) async =>
      await delete('pokemontypes/$id');
}
