import 'package:card_x_user/app/modules/card_ui/pokemon_set_model.dart';
import 'package:card_x_user/app/modules/card_ui/pokemon_supertypes_model.dart';
import 'package:card_x_user/app/modules/card_ui/pokemon_types_model.dart';
import 'package:card_x_user/app/modules/card_ui/product_entity_model.dart';
import 'package:card_x_user/app/modules/card_ui/sprite_card_model.dart';

class PokemonCardV2 {
  List<PokemonListing>? pokemonListing;
  int? page;
  int? pageSize;
  int? count;
  int? totalCount;
  Sprite? sprites;

  PokemonCardV2(
      {this.pokemonListing,
      this.page,
      this.pageSize,
      this.count,
      this.totalCount,
      this.sprites});

  PokemonCardV2.fromJson(Map<String, dynamic> json) {
    if (json['pokemonListing'] != null) {
      pokemonListing = <PokemonListing>[];
      json['pokemonListing'].forEach((v) {
        pokemonListing!.add(PokemonListing.fromJson(v));
      });
    }
    page = json['page'];
    pageSize = json['pageSize'];
    count = json['count'];
    totalCount = json['totalCount'];
    sprites = Sprite.fromJson(json['Sprites'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = pokemonListing!.map((v) => v.toJson()).toList();
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['count'] = count;
    data['totalCount'] = totalCount;
    data['sprites'] = sprites;
    return data;
  }
}

class PokemonListing {
  String? id;
  String? name;
  String? supertype;
  List<Supertypes>? subtypes;
  String? hp;
  List<Types>? types;
  String? evolvesFrom;
  List<Abilities>? abilities;
  List<Attacks>? attacks;
  List<Weaknesses>? weaknesses;
  List<String>? retreatCost;
  int? convertedRetreatCost;
  Set? set;
  String? number;
  String? artist;
  String? rarity;
  List<int>? nationalPokedexNumbers;
  Legalities? legalities;
  Images? images;
  Tcgplayer? tcgplayer;
  List<CardMarket>? cardmarket;
  List<String>? rules;
  String? level;
  String? flavorText;
  List<Resistances>? resistances;
  List<String>? evolvesTo;

  PokemonListing(
      {this.id,
      this.name,
      this.supertype,
      this.subtypes,
      this.hp,
      this.types,
      this.evolvesFrom,
      this.abilities,
      this.attacks,
      this.weaknesses,
      this.retreatCost,
      this.convertedRetreatCost,
      this.set,
      this.number,
      this.artist,
      this.rarity,
      this.nationalPokedexNumbers,
      this.legalities,
      this.images,
      this.tcgplayer,
      this.cardmarket,
      this.rules,
      this.level,
      this.flavorText,
      this.resistances,
      this.evolvesTo});

  PokemonListing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    supertype = json['supertype'];
    subtypes = json['subtypes'].cast<String>();
    hp = json['hp'];
    types = json['types'].cast<String>();
    evolvesFrom = json['evolvesFrom'];
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add(Abilities.fromJson(v));
      });
    }
    if (json['attacks'] != null) {
      attacks = <Attacks>[];
      json['attacks'].forEach((v) {
        attacks!.add(Attacks.fromJson(v));
      });
    }
    if (json['weaknesses'] != null) {
      weaknesses = <Weaknesses>[];
      json['weaknesses'].forEach((v) {
        weaknesses!.add(Weaknesses.fromJson(v));
      });
    }
    retreatCost = json['retreatCost'].cast<String>();
    convertedRetreatCost = json['convertedRetreatCost'];
    set = json['set'] != null ? Set?.fromJson(json['set']) : null;
    number = json['number'];
    artist = json['artist'];
    rarity = json['rarity'];
    nationalPokedexNumbers = json['nationalPokedexNumbers'].cast<int>();
    legalities = json['legalities'] != null
        ? Legalities?.fromJson(json['legalities'])
        : null;
    images = json['images'] != null ? Images?.fromJson(json['images']) : null;
    tcgplayer = json['tcgplayer'] != null
        ? Tcgplayer?.fromJson(json['tcgplayer'])
        : null;
    if (json['cardmarket'] != null){
      cardmarket = <CardMarket>[];
      json['cardmarket'].forEach((v) {
        cardmarket!.add(CardMarket.fromJson(v));
      });
    }
    rules = json['rules'].cast<String>();
    level = json['level'];
    flavorText = json['flavorText'];
    if (json['resistances'] != null) {
      resistances = <Resistances>[];
      json['resistances'].forEach((v) {
        resistances!.add(Resistances.fromJson(v));
      });
    }
    evolvesTo = json['evolvesTo'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['supertype'] = supertype;
    data['subtypes'] = subtypes;
    data['hp'] = hp;
    data['types'] = types;
    data['evolvesFrom'] = evolvesFrom;
    if (abilities != null) {
      data['abilities'] = abilities!.map((v) => v.toJson()).toList();
    }
    if (attacks != null) {
      data['attacks'] = attacks!.map((v) => v.toJson()).toList();
    }
    if (weaknesses != null) {
      data['weaknesses'] = weaknesses!.map((v) => v.toJson()).toList();
    }
    data['retreatCost'] = retreatCost;
    data['convertedRetreatCost'] = convertedRetreatCost;
    if (set != null) {
      data['set'] = set!.toJson();
    }
    data['number'] = number;
    data['artist'] = artist;
    data['rarity'] = rarity;
    data['nationalPokedexNumbers'] = nationalPokedexNumbers;
    if (legalities != null) {
      data['legalities'] = legalities!.toJson();
    }
    if (images != null) {
      data['images'] = images!.toJson();
    }
    if (tcgplayer != null) {
      data['tcgplayer'] = tcgplayer!.toJson();
    }
    if (cardmarket != null) {
      data['cardmarket'] = cardmarket!.map((v) => v.toJson()).toList();
    }
    data['rules'] = rules;
    data['level'] = level;
    data['flavorText'] = flavorText;
    if (resistances != null) {
      data['resistances'] = resistances!.map((v) => v.toJson()).toList();
    }
    data['evolvesTo'] = evolvesTo;
    return data;
  }
}

class CardMarket {
  String? url;
  String? updateAt;
  Prices? prices;

  CardMarket({this.url, this.updateAt, this.prices});

  CardMarket.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    updateAt = json['updateAt'];
    prices = json['prices'] != null ? Prices?.fromJson(json['prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['update'] = updateAt;
    data['prices'] = prices;
    return data;
  }
}

class WantsListItem {
  String? idWant;
  String? count;
  String? wishPrice;
  String? fromPrice;
  String? mailAlert;
  List<String>? type;
  String? idProduct;
  Product? product;
  List<String>? idLanguage;
  String? minCondition;
  String? isFoil;
  String? isSigned;
  String? isAltered;
  String? isFirstEd;

  WantsListItem(
      {this.idWant,
      this.count,
      this.wishPrice,
      this.fromPrice,
      this.mailAlert,
      this.type,
      this.idProduct,
      this.product,
      this.idLanguage,
      this.minCondition,
      this.isFoil,
      this.isSigned,
      this.isAltered,
      this.isFirstEd});

  WantsListItem.fromJson(Map<String, dynamic> json) {
    idWant = json['idWant'];
    count = json['count'];
    wishPrice = json['wishPrice'];
    fromPrice = json['fromPrice'];
    mailAlert = json['mailAlert'];
    type = json['type'];
    idProduct = json['idProduct'];
    idLanguage = json['idLanguage'];
    minCondition = json['minCondition'];
    isFoil = json['isFoil'];
    isSigned = json['isSigned'];
    isAltered = json['isAltered'];
    isFirstEd = json['isFirstEd'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idWant'] = idWant;
    data['count'] = count;
    data['wishPrice'] = wishPrice;
    data['fromPrice'] = fromPrice;
    data['mailAlert'] = mailAlert;
    data['type'] = type;
    data['minCondition'] = minCondition;
    data['isSigned'] = isSigned;
    data['isFoil'] = isFoil;
    data['isAltered'] = isAltered;
    data['isFirstEd'] = isFirstEd;
    data['idLanguage'] = idLanguage;
    data['idProduct'] = idProduct;
    data['product'] = product;
    return data;
  }
}

class Abilities {
  String? name;
  String? text;
  String? type;

  Abilities({this.name, this.text, this.type});

  Abilities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['text'] = text;
    data['type'] = type;
    return data;
  }
}

class Attacks {
  String? name;
  List<String>? cost;
  int? convertedEnergyCost;
  String? damage;
  String? text;

  Attacks(
      {this.name, this.cost, this.convertedEnergyCost, this.damage, this.text});

  Attacks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cost = json['cost'].cast<String>();
    convertedEnergyCost = json['convertedEnergyCost'];
    damage = json['damage'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['cost'] = cost;
    data['convertedEnergyCost'] = convertedEnergyCost;
    data['damage'] = damage;
    data['text'] = text;
    return data;
  }
}

class Weaknesses {
  String? type;
  String? value;

  Weaknesses({this.type, this.value});

  Weaknesses.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}

/*
class Images {
  String? small;
  String? large;

  Images({this.small, this.large});

  Images.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['small'] = small;
    data['large'] = large;
    return data;
  }
}
*/

class Resistances {
  String? type;
  String? value;

  Resistances({this.type, this.value});

  Resistances.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}

class Tcgplayer {
  String? url;
  String? updatedAt;
  Prices? prices;

  Tcgplayer({this.url, this.updatedAt, this.prices});

  Tcgplayer.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    updatedAt = json['updatedAt'];
    prices = json['prices'] != null ? Prices?.fromJson(json['prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['updatedAt'] = updatedAt;
    if (prices != null) {
      data['prices'] = prices!.toJson();
    }
    return data;
  }
}

/*
class Prices {
  Holofoil? holofoil;
  ReverseHolofoil? reverseHolofoil;
  Normal? normal;

  Prices({this.holofoil, this.reverseHolofoil, this.normal});

  Prices.fromJson(Map<String, dynamic> json) {
    holofoil =
    json['holofoil'] != null ? Holofoil?.fromJson(json['holofoil']) : null;
    reverseHolofoil = json['reverseHolofoil'] != null
        ? ReverseHolofoil?.fromJson(json['reverseHolofoil'])
        : null;
    normal = json['normal'] != null
        ? ReverseHolofoil?.fromJson(json['normal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (holofoil != null) {
      data['holofoil'] = holofoil!.toJson();
    }
    if (reverseHolofoil != null) {
      data['reverseHolofoil'] = reverseHolofoil.toJson();
    }
    if (normal != null) {
      data['normal'] = normal.toJson();
    }
    return data;
  }
}
*/

class Holofoil {
  double? low;
  double? mid;
  double? high;
  double? market;
  double? directLow;

  Holofoil({this.low, this.mid, this.high, this.market, this.directLow});

  Holofoil.fromJson(Map<String, dynamic> json) {
    low = json['low'];
    mid = json['mid'];
    high = json['high'];
    market = json['market'];
    directLow = json['directLow'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['low'] = low;
    data['mid'] = mid;
    data['high'] = high;
    data['market'] = market;
    data['directLow'] = directLow;
    return data;
  }
}

class Prices {
  double? averageSellPrice;
  double? lowPrice;
  double? trendPrice;
  dynamic germanProLow;
  dynamic suggestedPrice;
  double? reverseHoloSell;
  double? reverseHoloLow;
  double? reverseHoloTrend;
  double? lowPriceExPlus;
  double? avg1;
  double? avg7;
  double? avg30;
  double? reverseHoloAvg1;
  double? reverseHoloAvg7;
  double? reverseHoloAvg30;

  Prices(
      {this.averageSellPrice,
      this.lowPrice,
      this.trendPrice,
      this.germanProLow,
      this.suggestedPrice,
      this.reverseHoloSell,
      this.reverseHoloLow,
      this.reverseHoloTrend,
      this.lowPriceExPlus,
      this.avg1,
      this.avg7,
      this.avg30,
      this.reverseHoloAvg1,
      this.reverseHoloAvg7,
      this.reverseHoloAvg30});

  Prices.fromJson(Map<String, dynamic> json) {
    averageSellPrice = json['averageSellPrice'];
    lowPrice = json['lowPrice'];
    trendPrice = json['trendPrice'];
    germanProLow = json['germanProLow'];
    suggestedPrice = json['suggestedPrice'];
    reverseHoloSell = json['reverseHoloSell'];
    reverseHoloLow = json['reverseHoloLow'];
    reverseHoloTrend = json['reverseHoloTrend'];
    lowPriceExPlus = json['lowPriceExPlus'];
    avg1 = json['avg1'];
    avg7 = json['avg7'];
    avg30 = json['avg30'];
    reverseHoloAvg1 = json['reverseHoloAvg1'];
    reverseHoloAvg7 = json['reverseHoloAvg7'];
    reverseHoloAvg30 = json['reverseHoloAvg30'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['averageSellPrice'] = averageSellPrice;
    data['lowPrice'] = lowPrice;
    data['trendPrice'] = trendPrice;
    data['germanProLow'] = germanProLow;
    data['suggestedPrice'] = suggestedPrice;
    data['reverseHoloSell'] = reverseHoloSell;
    data['reverseHoloLow'] = reverseHoloLow;
    data['reverseHoloTrend'] = reverseHoloTrend;
    data['lowPriceExPlus'] = lowPriceExPlus;
    data['avg1'] = avg1;
    data['avg7'] = avg7;
    data['avg30'] = avg30;
    data['reverseHoloAvg1'] = reverseHoloAvg1;
    data['reverseHoloAvg7'] = reverseHoloAvg7;
    data['reverseHoloAvg30'] = reverseHoloAvg30;
    return data;
  }
}
