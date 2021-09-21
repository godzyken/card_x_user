class PokemonSubtypes {
  List<String>? data;

  PokemonSubtypes({this.data});

  PokemonSubtypes.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = data;
    return data;
  }
}
