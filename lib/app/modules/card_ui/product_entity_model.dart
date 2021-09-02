class ProductEntity {
  Product? product;

  ProductEntity({this.product});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product?.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? idProduct;
  int? idMetaproduct;
  int? countReprints;
  String? enName;
  List<Localization>? localization;
  String? website;
  String? image;
  String? gameName;
  String? categoryName;
  String? number;
  String? rarity;
  Expansion? expansion;
  PriceGuide? priceGuide;
  List<Reprint>? reprint;
  Links? links;

  Product(
      {this.idProduct,
      this.idMetaproduct,
      this.countReprints,
      this.enName,
      this.localization,
      this.website,
      this.image,
      this.gameName,
      this.categoryName,
      this.number,
      this.rarity,
      this.expansion,
      this.priceGuide,
      this.reprint,
      this.links});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    idMetaproduct = json['idMetaproduct'];
    countReprints = json['countReprints'];
    enName = json['enName'];
    if (json['localization'] != null) {
      localization = <Localization>[];
      json['localization'].forEach((v) {
        localization!.add(Localization.fromJson(v));
      });
    }
    website = json['website'];
    image = json['image'];
    gameName = json['gameName'];
    categoryName = json['categoryName'];
    number = json['number'];
    rarity = json['rarity'];
    expansion =
        json['expansion'] != null ? Expansion?.fromJson(json['expansion']) : null;
    priceGuide =
        json['priceGuide'] != null ? PriceGuide?.fromJson(json['priceGuide']) : null;
    if (json['reprint'] != null) {
      reprint = <Reprint>[];
      json['reprint'].forEach((v) {
        reprint!.add(Reprint.fromJson(v));
      });
    }
    links = json['links'] != null ? Links?.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idProduct'] = idProduct;
    data['idMetaproduct'] = idMetaproduct;
    data['countReprints'] = countReprints;
    data['enName'] = enName;
    if (localization != null) {
      data['localization'] = localization!.map((v) => v.toJson()).toList();
    }
    data['website'] = website;
    data['image'] = image;
    data['gameName'] = gameName;
    data['categoryName'] = categoryName;
    data['number'] = number;
    data['rarity'] = rarity;
    if (expansion != null) {
      data['expansion'] = expansion!.toJson();
    }
    if (priceGuide != null) {
      data['priceGuide'] = priceGuide!.toJson();
    }
    if (reprint != null) {
      data['reprint'] = reprint!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class Localization {
  int? idLanguage;
  String? languageName;
  String? productName;

  Localization({this.idLanguage, this.languageName, this.productName});

  Localization.fromJson(Map<String, dynamic> json) {
    idLanguage = json['idLanguage'];
    languageName = json['languageName'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idLanguage'] = idLanguage;
    data['languageName'] = languageName;
    data['productName'] = productName;
    return data;
  }
}

class Expansion {
  int? idExpansion;
  String? enName;
  int? expansionIcon;

  Expansion({this.idExpansion, this.enName, this.expansionIcon});

  Expansion.fromJson(Map<String, dynamic> json) {
    idExpansion = json['idExpansion'];
    enName = json['enName'];
    expansionIcon = json['expansionIcon'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idExpansion'] = idExpansion;
    data['enName'] = enName;
    data['expansionIcon'] = expansionIcon;
    return data;
  }
}

class PriceGuide {
  double? sELL;
  double? lOW;
  int? lOWEX;
  double? lOWFOIL;
  double? aVG;
  double? tREND;
  double? tRENDFOIL;

  PriceGuide(
      {this.sELL,
      this.lOW,
      this.lOWEX,
      this.lOWFOIL,
      this.aVG,
      this.tREND,
      this.tRENDFOIL});

  PriceGuide.fromJson(Map<String, dynamic> json) {
    sELL = json['SELL'];
    lOW = json['LOW'];
    lOWEX = json['LOWEX'];
    lOWFOIL = json['LOWFOIL'];
    aVG = json['AVG'];
    tREND = json['TREND'];
    tRENDFOIL = json['TRENDFOIL'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['SELL'] = sELL;
    data['LOW'] = lOW;
    data['LOWEX'] = lOWEX;
    data['LOWFOIL'] = lOWFOIL;
    data['AVG'] = aVG;
    data['TREND'] = tREND;
    data['TRENDFOIL'] = tRENDFOIL;
    return data;
  }
}

class Reprint {
  int? idProduct;
  String? expansion;
  int? expansionIcon;

  Reprint({this.idProduct, this.expansion, this.expansionIcon});

  Reprint.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    expansion = json['expansion'];
    expansionIcon = json['expansionIcon'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idProduct'] = idProduct;
    data['expansion'] = expansion;
    data['expansionIcon'] = expansionIcon;
    return data;
  }
}

class Links {
  String? url;

  Links({this.url});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
