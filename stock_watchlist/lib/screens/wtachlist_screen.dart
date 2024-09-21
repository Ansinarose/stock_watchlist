import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_watchlist/common/constants/colors.dart';
import 'package:stock_watchlist/common/constants/custom_appbar.dart';
import '../providers/stock_provider.dart';

class WatchlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Watchlist',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Table(
            border: TableBorder.all(
              color: Colors.black, // Color for the borders
              width: 1,            // Thickness of the borders
            ),
            columnWidths: const {
              0: FlexColumnWidth(2), // Adjust width of the company name column
              1: FlexColumnWidth(1.5), // Adjust width of the share price column
              2: FlexColumnWidth(1), // Adjust width of the actions column
            },
            children: [
              // Header Row
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade300),
                children: [
                  _buildTableHeader('Company'),
                  _buildTableHeader('Share Price'),
                  _buildTableHeader(''),
                ],
              ),
              // Data Rows
              ...stockProvider.watchlist.map((stock) {
                return TableRow(
                  children: [
                    _buildTableCell(stock.name),
                    _buildTableCell(stock.price),
                    _buildTableCellWithIcon(
                      Icons.cancel_outlined,
                      () {
                        stockProvider.removeFromWatchlist(stock);
                      },
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for building table headers
  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper for building table cells with text
  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper for building table cells with an icon button
  Widget _buildTableCellWithIcon(IconData icon, VoidCallback onPressed) {
    return Center(
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
