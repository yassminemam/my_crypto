class CoinPriceResponse {
  Map<String, dynamic>? prices;

  CoinPriceResponse({this.prices});

  CoinPriceResponse.fromJson(Map<String, dynamic> json) {
    prices =
        Map<String, dynamic>.fromEntries(json.entries);
  }
}
