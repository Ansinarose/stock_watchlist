import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stock_provider.dart';
import '../widgets/stock_tile.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: stockProvider.watchlist.isEmpty
          ? const Center(child: Text('No stocks in watchlist'))
          : ListView.builder(
              itemCount: stockProvider.watchlist.length,
              itemBuilder: (context, index) {
                final stock = stockProvider.watchlist[index];
                return StockTile(stock: stock, isWatchlist: true);
              },
            ),
    );
  }
}
