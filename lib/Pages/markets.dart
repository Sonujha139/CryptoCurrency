import 'package:cryptocurrency/Pages/details.dart';
import 'package:cryptocurrency/models/cryptocurrency.dart';
import 'package:cryptocurrency/provider/market_provider.dart';
import 'package:cryptocurrency/widget/CryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.length > 0) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: marketProvider.markets.length,
              itemBuilder: (context, index) {
                CryptoCurrency currentCrypto = marketProvider.markets[index];
                return CryptoListTile(currentCrypto: currentCrypto);
              },
            );
          } else {
            return const Text("Data Not Found");
          }
        }
      },
    );
  }
}
