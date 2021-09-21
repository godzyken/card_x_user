import 'package:get/get.dart';

import '../models/pokemon_rarities_model.dart';

class PokemonRaritiesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return PokemonRarities.fromJson(map);
      if (map is List)
        return map.map((item) => PokemonRarities.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<PokemonRarities?> getPokemonRarities(int id) async {
    final response = await get('pokemonrarities/$id');
    return response.body;
  }

  Future<Response<PokemonRarities>> postPokemonRarities(
          PokemonRarities pokemonrarities) async =>
      await post('pokemonrarities', pokemonrarities);
  Future<Response> deletePokemonRarities(int id) async =>
      await delete('pokemonrarities/$id');
}
