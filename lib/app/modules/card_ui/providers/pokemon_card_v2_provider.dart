import 'package:get/get.dart';

import '../pokemon_card_v2_model.dart';

class PokemonCardV2Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return PokemonCardV2.fromJson(map);
      if (map is List)
        return map.map((item) => PokemonCardV2.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<PokemonCardV2?> getPokemonCardV2(int id) async {
    final response = await get('pokemoncardv2/$id');
    return response.body;
  }

  Future<Response<PokemonCardV2>> postPokemonCardV2(
          PokemonCardV2 pokemoncardv2) async =>
      await post('pokemoncardv2', pokemoncardv2);
  Future<Response> deletePokemonCardV2(int id) async =>
      await delete('pokemoncardv2/$id');
}
