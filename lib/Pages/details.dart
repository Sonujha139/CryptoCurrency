import 'package:cryptocurrency/models/cryptocurrency.dart';
import 'package:cryptocurrency/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
//  DetailsPage({Key? key}) : super(key: key);

  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
         Text(title, style: const TextStyle(
           fontWeight:FontWeight.bold,
           fontSize: 17
         ),),
         Text(detail, style:const TextStyle(
           fontSize: 17,
         ),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {
                CryptoCurrency currentCrypto =
                    marketProvider.fetchCryptoById(widget.id);
                return ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(
                        currentCrypto.name! +
                            "(${currentCrypto.symbol!.toUpperCase()})",
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "₹ " + currentCrypto.currentPrice!.toStringAsFixed(3),
                        style: const TextStyle(
                            color: Color(0xff0395eb),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                     const SizedBox(height: 20,) ,     
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                         const Text("Price Change (24h)", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                          Builder(builder: (context) {
                                double priceChange =
                                    currentCrypto.priceChange24!;
                                double priceChangePercentage =
                                    currentCrypto.priceChangePercentage24!;

                                if (priceChange < 0) {
                                  // negative
                                  return Text(
                                    "${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(3)})",
                                    style: const  TextStyle(color: Colors.red, fontSize: 23),
                                  );
                                } else {
                                  // positive
                                  return Text(
                                    "+${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(3)})",
                                    style: const TextStyle(color: Colors.green, fontSize: 23),
                                  );
                                }
                              },),
                        ],
                      ),




                  const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("Market Cap","₹ " + currentCrypto.marketCap!.toStringAsFixed(3), CrossAxisAlignment.start),
                        titleAndDetail("Market Cap Rank","# "+currentCrypto.marketCapRank.toString(), CrossAxisAlignment.end),
                      ],
                    ),
                   const  SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("Low 24h","₹ " + currentCrypto.low24!.toStringAsFixed(3), CrossAxisAlignment.start),
                        titleAndDetail("High 24h","₹ "+currentCrypto.high24h!.toStringAsFixed(3), CrossAxisAlignment.end),
                      ],
                    ),
                   const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("Circulating Supply", currentCrypto.circulatingSupply!.toInt().toString(), CrossAxisAlignment.start),
                        
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("All Time Low", currentCrypto.atl!.toStringAsFixed(3), CrossAxisAlignment.start),
                          titleAndDetail("All Time High",  currentCrypto.atl!.toStringAsFixed(3), CrossAxisAlignment.start),
                        
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
