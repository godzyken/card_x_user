import 'dart:convert';

import '../models/models.dart';
import 'package:http/http.dart' as http;
import 'package:card_x_user/app/modules/card_ui/services/type_aliases.dart';

class CardMarketApi {
  CardMarketApi({this.options});

  final String? options;

  static const _baseUrl = 'https://api.cardmarket.com/ws/v2.0';
  static const _setsUrl = '$_baseUrl/sets';

  /// Gets a paginated list of all pokemon cards.
  Future<List<PokemonListing>> getCards({
    int page = 0,
  }) async {
    http.Response response;
    if (page == 0) {
      response = await http.get(
        Uri.parse('$_baseUrl/cards'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    } else {
      response = await http.get(
        Uri.parse('$_baseUrl/cards?page=$page'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    }

    JsonMap json = jsonDecode(response.body);
    final cards = <PokemonListing>[];
    List<dynamic> cardsJson = json['data'];
    cardsJson.forEach((element) {
      cards.add(PokemonListing.fromJson(element));
    });
    return cards;
  }

  /// Gets a paginated list of all pokemon cards for a particular set.
  Future<List<PokemonListing>> getCardsForSet(
    String setId, {
    int page = 0,
  }) async {
    http.Response response;
    if (page == 0) {
      response = await http.get(
        Uri.parse('$_baseUrl/cards?q=set.id:$setId'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    } else {
      response = await http.get(
        Uri.parse('$_baseUrl/cards?q=set.id:$setId&page=$page'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    }

    JsonMap json = jsonDecode(response.body);
    final cards = <PokemonListing>[];
    List<dynamic> cardsJson = json['data'];
    cardsJson.forEach((element) {
      cards.add(PokemonListing.fromJson(element));
    });
    return cards;
  }

  /// Gets a single pokemon card based on the card ID (e.g. 'xy7-54')
  Future<PokemonListing> getCard(String cardId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products/find?search=$cardId'),
      headers: {
        'Content-Type': options!,
      },
    );

    print(response.request);

    final json = jsonDecode(response.body);
    return PokemonListing.fromJson(json['data']);
  }

  /// Get All Sets
  Future<CardSets> getSets() async {
    final response = await http.get(
      Uri.parse(_setsUrl),
      headers: {
        'X-Request-Limit-Max': options!,
      },
    );

    JsonMap json = jsonDecode(response.body);
    final cardSets = <Set>[];
    List<dynamic> sets = json['data'];
    sets.forEach((element) {
      cardSets.add(Set.fromJson(element));
    });
    return cardSets;
  }

  /// Returns a specific set by the set code
  Future<Set> getSet(String setId) async {
    final response = await http.get(
      Uri.parse('$_setsUrl/$setId'),
      headers: {
        'X-Request-Limit-Max': options!,
      },
    );

    final json = jsonDecode(response.body);
    return Set.fromJson(json['data']);
  }

  /// Gets a paginated list of all Articles.
  Future<List<Article>> getArticles({
    int page = 0,
  }) async {
    http.Response response;
    if (page == 0) {
      response = await http.get(
        Uri.parse('$_baseUrl/articles'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    } else {
      response = await http.get(
        Uri.parse('$_baseUrl/articles?page=$page'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    }

    JsonMap json = jsonDecode(response.body);
    final articles = <Article>[];
    List<dynamic> articlesJson = json['data'];
    articlesJson.forEach((element) {
      articles.add(Article.fromJson(element));
    });
    return articles;
  }

  /// Gets a paginated list of all articles for a particular set.
  Future<List<Article>> getArticlesForSet(
    String setId, {
    int page = 0,
  }) async {
    http.Response response;
    if (page == 0) {
      response = await http.get(
        Uri.parse('$_baseUrl/articles?q=set.id:$setId'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    } else {
      response = await http.get(
        Uri.parse('$_baseUrl/articles?q=set.id:$setId&page=$page'),
        headers: {
          'X-Request-Limit-Max': options!,
        },
      );
    }

    JsonMap json = jsonDecode(response.body);
    final articles = <Article>[];
    List<dynamic> articlesJson = json['data'];
    articlesJson.forEach((element) {
      articles.add(Article.fromJson(element));
    });
    return articles;
  }

  /// Gets a single pokemon card based on the Article ID (e.g. 'xy7-54')
  Future<Article> getArticle(String articleId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/articles/$articleId'),
      headers: {
        'X-Request-Limit-Max': options!,
      },
    );

    final json = jsonDecode(response.body);
    return Article.fromJson(json['data']);
  }
}
