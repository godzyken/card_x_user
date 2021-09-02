import 'package:get/get.dart';

import '../pokemon_subtypes_model.dart';

class PokemonSubtypesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return PokemonSubtypes.fromJson(map);
      if (map is List)
        return map.map((item) => PokemonSubtypes.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<PokemonSubtypes?> getPokemonSubtypes(int id) async {
    final response = await get('pokemonsubtypes/$id');
    return response.body;
  }

  Future<Response<PokemonSubtypes>> postPokemonSubtypes(
          PokemonSubtypes pokemonsubtypes) async =>
      await post('pokemonsubtypes', pokemonsubtypes);
  Future<Response> deletePokemonSubtypes(int id) async =>
      await delete('pokemonsubtypes/$id');
}
