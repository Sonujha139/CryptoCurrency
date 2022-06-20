class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? high24h;
  double? low24;
  double? priceChange24;
  double? priceChangePercentage24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavorite = false;

  CryptoCurrency(
      {required this.id,
      required this.ath,
      required this.atl,
      required this.circulatingSupply,
      required this.currentPrice,
      required this.high24h,
      required this.image,
      required this.low24,
      required this.marketCap,
      required this.marketCapRank,
      required this.name,
      required this.priceChange24,
      required this.priceChangePercentage24,
      required this.symbol});

  factory CryptoCurrency.fromJson(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map["id"],
        ath: double.parse(map["ath"].toString()),
        atl: double.parse(map["atl"].toString()),
        circulatingSupply: double.parse(map["circulating_supply"].toString()),
        currentPrice: double.parse(map["current_price"].toString()),
        high24h: double.parse(map["high_24h"].toString()),
        image: map["image"],
        low24: double.parse(map["low_24h"].toString()),
        marketCap: double.parse(map["market_cap"].toString()),
        marketCapRank: map["market_cap_rank"],
        name: map["name"],
        priceChange24: double.parse(map["price_change_24h"].toString()),
        priceChangePercentage24:
            double.parse(map["price_change_percentage_24h"].toString()),
        symbol: map["symbol"]);
  }
}
