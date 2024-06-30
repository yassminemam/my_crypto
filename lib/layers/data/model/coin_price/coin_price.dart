class CoinPrice {
  double? uSD;

  CoinPrice({this.uSD});

  CoinPrice.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['USD'] = this.uSD;
    return data;
  }
}
