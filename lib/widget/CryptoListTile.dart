import 'package:cryptocurrency/Pages/details.dart';
import 'package:cryptocurrency/models/cryptocurrency.dart';
import 'package:cryptocurrency/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currentCrypto;
  const CryptoListTile({Key? key,required this.currentCrypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      id: currentCrypto.id!,
                    )));
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currentCrypto.name!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 19,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 19,
                    color: Colors.red,
                  ),
                )
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(3),
            style: const TextStyle(
                color: Color(0xff0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;

            if (priceChange < 0) {
              // negative
              return Text(
                "${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(3)})",
                style: TextStyle(color: Colors.red),
              );
            } else {
              // positive
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(3)})",
                style: TextStyle(color: Colors.green),
              );
            }
          })
        ],
      ),
    );
  }
}
