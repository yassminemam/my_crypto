class CoinsListResponse {
  String? response;
  String? message;
  bool? hasWarning;
  int? type;
  RateLimit? rateLimit;
  Data? data;

  CoinsListResponse(
      {this.response,
      this.message,
      this.hasWarning,
      this.type,
      this.rateLimit,
      this.data});

  CoinsListResponse.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    message = json['Message'];
    hasWarning = json['HasWarning'];
    type = json['Type'];
    rateLimit = json['RateLimit'] != null
        ? RateLimit.fromJson(json['RateLimit'])
        : null;
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
}

class RateLimit {
  RateLimit.fromJson(Map<String, dynamic> json);
}

class Data {
  Data({required this.coins});

  List<Coin> coins = [];

  Data.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> coinsMap =
        Map<String, dynamic>.fromEntries(json.entries);
    for (var coin in coinsMap.values) {
      coins.add(Coin.fromJson(coin));
    }
  }
}

class Coin {
  int? id;
  String? symbol;
  String? partnerSymbol;
  int? dataAvailableFrom;

  Coin({this.id, this.symbol, this.partnerSymbol, this.dataAvailableFrom});

  Coin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    partnerSymbol = json['partner_symbol'];
    dataAvailableFrom = json['data_available_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['partner_symbol'] = partnerSymbol;
    data['data_available_from'] = dataAvailableFrom;
    return data;
  }
}
