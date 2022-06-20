import 'dart:async';

import 'package:cryptocurrency/Api/Api.dart';
import 'package:cryptocurrency/models/LocalStorage.dart';
import 'package:cryptocurrency/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchdata();
  }

  void fetchdata() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorites();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      fetchdata();
      print("Data Updated");
    });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorite(CryptoCurrency crypto) async {
    int indexofCrypto = markets.indexOf(crypto);
    markets[indexofCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency crypto) async {
    int indexofCrypto = markets.indexOf(crypto);
    markets[indexofCrypto].isFavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
