import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_watchlist/common/constants/colors.dart';
import 'package:stock_watchlist/common/constants/custom_appbar.dart';
import 'package:stock_watchlist/common/widgets/bottom_navbar.dart';
import 'package:stock_watchlist/screens/wtachlist_screen.dart';
import '../providers/stock_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Stocks Search',
      ),
      body: _currentIndex == 0 ? _buildHomeContent(stockProvider) : WatchlistScreen(),
      bottomNavigationBar: CustomBottomNavBar(
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
    final query = _searchController.text;

    return Padding(
      padding: const EdgeInsets.all(15.0), // Padding applied to the entire column
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (query) {
              setState(() {}); // Force a rebuild to show results or "No search data"
              if (query.length >= 2) {
                stockProvider.searchStocks(query);
              }
            },
            decoration: InputDecoration(
              hintText: 'Search Stocks',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppConstants.primaryColor, width: 3),
              ),
              suffixIcon: Icon(Icons.search),
            ),
          ),
         
          Expanded(
            child: query.isEmpty
                ? Center(
                    child: Text(
                      'No search data',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : stockProvider.searchResults.isEmpty
                    ? Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: stockProvider.searchResults.length,
                        itemBuilder: (context, index) {
                          final stock = stockProvider.searchResults[index];
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  title: Row(
                                    children: [
                                      Text(stock.symbol),
                                      SizedBox(width: 10),
                                      Text(
                                        '(Rs: ${stock.price})',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      stockProvider.addToWatchlist(stock);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: AppConstants.primaryColor,
                                          content: Text('Added to watchlist'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey, // Color of the divider between ListTile rows
                                height: 1, // Height of the divider line
                              ),
                            ],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
