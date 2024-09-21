import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_watchlist/models/stock_model.dart';
import 'package:stock_watchlist/providers/stock_provider.dart';


class StockTile extends StatelessWidget {
  final StockModel stock;
  final bool isWatchlist;

  const StockTile({
    Key? key,
    required this.stock,
    required this.isWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return ListTile(
      title: Text(stock.name),
      subtitle: Text('\$${stock.price.isNotEmpty ? double.parse(stock.price).toStringAsFixed(2) : '0.00'}'),
      trailing: isWatchlist
          ? IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                stockProvider.removeFromWatchlist(stock);
              },
            )
          : IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                stockProvider.addToWatchlist(stock);
              },
            ),
    );
  }
}
