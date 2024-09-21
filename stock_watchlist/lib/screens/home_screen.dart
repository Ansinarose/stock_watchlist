import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_watchlist/common/constants/colors.dart';
import 'package:stock_watchlist/common/constants/custom_appbar.dart';
import 'package:stock_watchlist/common/widgets/bottom_navbar.dart';
import 'package:stock_watchlist/screens/wtachlist_screen.dart';
import '../providers/stock_provider.dart';
import '../models/stock_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: _currentIndex == 0 ? _buildHomeContent(stockProvider) : WatchlistScreen(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeContent(StockProvider stockProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query) {
              if (query.length >= 2) {
                stockProvider.searchStocks(query);
              }
            },
            decoration: InputDecoration(
              labelText: 'Search Stocks',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: stockProvider.searchResults.length,
            itemBuilder: (context, index) {
              final stock = stockProvider.searchResults[index];
              return ListTile(
                title: Text(stock.name),
                subtitle: Text(stock.symbol),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    stockProvider.addToWatchlist(stock);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to watchlist')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}