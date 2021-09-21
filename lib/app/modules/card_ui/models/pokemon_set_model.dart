class Set {
  String? id;
  String? name;
  String? series;
  int? printedTotal;
  int? total;
  Legalities? legalities;
  String? ptcgoCode;
  String? releaseDate;
  String? updatedAt;
  Images? images;

  Set(
      {this.id,
      this.name,
      this.series,
      this.printedTotal,
      this.total,
      this.legalities,
      this.ptcgoCode,
      this.releaseDate,
      this.updatedAt,
      this.images});

  Set.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    series = json['series'];
    printedTotal = json['printedTotal'];
    total = json['total'];
    legalities =
        json['legalities'] != null ? Legalities?.fromJson(json['legalities']) : null;
    ptcgoCode = json['ptcgoCode'];
    releaseDate = json['releaseDate'];
    updatedAt = json['updatedAt'];
    images = json['images'] != null ? Images?.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['series'] = series;
    data['printedTotal'] = printedTotal;
    data['total'] = total;
    if (legalities != null) {
      data['legalities'] = legalities!.toJson();
    }
    data['ptcgoCode'] = ptcgoCode;
    data['releaseDate'] = releaseDate;
    data['updatedAt'] = updatedAt;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    return data;
  }
}

class Legalities {
  String? unlimited;
  String? standard;
  String? expanded;

  Legalities({this.unlimited, this.standard, this.expanded});

  Legalities.fromJson(Map<String, dynamic> json) {
    unlimited = json['unlimited'];
    standard = json['standard'];
    expanded = json['expanded'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['unlimited'] = unlimited;
    data['standard'] = standard;
    data['expanded'] = expanded;
    return data;
  }
}

class Images {
  String? symbol;
  String? logo;

  Images({this.symbol, this.logo});

  Images.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['logo'] = logo;
    return data;
  }
}
