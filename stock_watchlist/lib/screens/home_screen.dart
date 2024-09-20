import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_watchlist/screens/wtachlist_screen.dart';
import '../providers/stock_provider.dart';
import '../widgets/stock_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WatchlistScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for a company...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                stockProvider.searchStocks(value);
              },
            ),
          ),
          Expanded(
            child: stockProvider.searchResults.isEmpty
                ? const Center(child: Text('No results'))
                : ListView.builder(
                    itemCount: stockProvider.searchResults.length,
                    itemBuilder: (context, index) {
                      final stock = stockProvider.searchResults[index];
                      return StockTile(stock: stock, isWatchlist: false);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
