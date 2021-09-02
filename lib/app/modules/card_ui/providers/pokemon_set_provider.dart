import 'package:get/get.dart';

import '../pokemon_set_model.dart';

class PokemonSetProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Set.fromJson(map);
      if (map is List)
        return map.map((item) => Set.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Set?> getPokemonSet(int id) async {
    final response = await get('pokemonset/$id');
    return response.body;
  }

  Future<Response<Set>> postPokemonSet(Set pokemonset) async =>
      await post('pokemonset', pokemonset);
  Future<Response> deletePokemonSet(int id) async =>
      await delete('pokemonset/$id');
}
