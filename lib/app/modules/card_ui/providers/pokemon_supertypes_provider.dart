import 'package:get/get.dart';

import '../pokemon_supertypes_model.dart';

class PokemonSupertypesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Supertypes.fromJson(map);
      if (map is List)
        return map.map((item) => Supertypes.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Supertypes?> getPokemonSupertypes(int id) async {
    final response = await get('pokemonsupertypes/$id');
    return response.body;
  }

  Future<Response<Supertypes>> postPokemonSupertypes(
          Supertypes pokemonsupertypes) async =>
      await post('pokemonsupertypes', pokemonsupertypes);
  Future<Response> deletePokemonSupertypes(int id) async =>
      await delete('pokemonsupertypes/$id');
}
