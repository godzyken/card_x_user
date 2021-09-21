class ArticleEntity {
  List<Article>? article;

  ArticleEntity({this.article});

  ArticleEntity.fromJson(Map<String, dynamic> json) {
    if (json['article'] != null) {
      article = <Article>[];
      json['article'].forEach((v) {
        article!.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (article != null) {
      data['article'] = article!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article {
  int? idArticle;
  int? idProduct;
  Language? language;
  String? comments;
  double? price;
  int? count;
  bool? inShoppingCart;
  Seller? seller;
  String? condition;
  bool? isFoil;
  bool? isSigned;
  bool? isAltered;
  bool? isPlayset;
  Links? links;

  Article(
      {this.idArticle,
      this.idProduct,
      this.language,
      this.comments,
      this.price,
      this.count,
      this.inShoppingCart,
      this.seller,
      this.condition,
      this.isFoil,
      this.isSigned,
      this.isAltered,
      this.isPlayset,
      this.links});

  Article.fromJson(Map<String, dynamic> json) {
    idArticle = json['idArticle'];
    idProduct = json['idProduct'];
    language =
        json['language'] != null ? Language?.fromJson(json['language']) : null;
    comments = json['comments'];
    price = json['price'];
    count = json['count'];
    inShoppingCart = json['inShoppingCart'];
    seller = json['seller'] != null ? Seller?.fromJson(json['seller']) : null;
    condition = json['condition'];
    isFoil = json['isFoil'];
    isSigned = json['isSigned'];
    isAltered = json['isAltered'];
    isPlayset = json['isPlayset'];
    links = json['links'] != null ? Links?.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idArticle'] = idArticle;
    data['idProduct'] = idProduct;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    data['comments'] = comments;
    data['price'] = price;
    data['count'] = count;
    data['inShoppingCart'] = inShoppingCart;
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['condition'] = condition;
    data['isFoil'] = isFoil;
    data['isSigned'] = isSigned;
    data['isAltered'] = isAltered;
    data['isPlayset'] = isPlayset;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class Language {
  int? idLanguage;
  String? languageName;

  Language({this.idLanguage, this.languageName});

  Language.fromJson(Map<String, dynamic> json) {
    idLanguage = json['idLanguage'];
    languageName = json['languageName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idLanguage'] = idLanguage;
    data['languageName'] = languageName;
    return data;
  }
}

class Seller {
  int? idUser;
  String? username;
  String? registrationDate;
  int? isCommercial;
  bool? isSeller;
  Name? name;
  Address? address;
  String? phone;
  String? email;
  String? vat;
  int? riskGroup;
  int? reputation;
  int? shipsFast;
  int? sellCount;
  int? soldItems;
  int? avgShippingTime;
  bool? onVacation;

  Seller(
      {this.idUser,
      this.username,
      this.registrationDate,
      this.isCommercial,
      this.isSeller,
      this.name,
      this.address,
      this.phone,
      this.email,
      this.vat,
      this.riskGroup,
      this.reputation,
      this.shipsFast,
      this.sellCount,
      this.soldItems,
      this.avgShippingTime,
      this.onVacation});

  Seller.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    username = json['username'];
    registrationDate = json['registrationDate'];
    isCommercial = json['isCommercial'];
    isSeller = json['isSeller'];
    name = json['name'] != null ? Name?.fromJson(json['name']) : null;
    address = json['address'] != null ? Address?.fromJson(json['address']) : null;
    phone = json['phone'];
    email = json['email'];
    vat = json['vat'];
    riskGroup = json['riskGroup'];
    reputation = json['reputation'];
    shipsFast = json['shipsFast'];
    sellCount = json['sellCount'];
    soldItems = json['soldItems'];
    avgShippingTime = json['avgShippingTime'];
    onVacation = json['onVacation'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['username'] = username;
    data['registrationDate'] = registrationDate;
    data['isCommercial'] = isCommercial;
    data['isSeller'] = isSeller;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['phone'] = phone;
    data['email'] = email;
    data['vat'] = vat;
    data['riskGroup'] = riskGroup;
    data['reputation'] = reputation;
    data['shipsFast'] = shipsFast;
    data['sellCount'] = sellCount;
    data['soldItems'] = soldItems;
    data['avgShippingTime'] = avgShippingTime;
    data['onVacation'] = onVacation;
    return data;
  }
}

class Name {
  String? firstName;

  Name({this.firstName});

  Name.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    return data;
  }
}

class Address {
  String? country;

  Address({this.country});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country'] = country;
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
