import 'dart:math';
import '../models/stock_model.dart';

class MockStockRepository {
  final List<StockModel> _mockStocks = [
    StockModel(name: 'Apple Inc.', symbol: 'AAPL', price: '150.25'),
    StockModel(name: 'Microsoft Corporation', symbol: 'MSFT', price: '280.75'),
    StockModel(name: 'Amazon.com Inc.', symbol: 'AMZN', price: '3300.50'),
    StockModel(name: 'Alphabet Inc.', symbol: 'GOOGL', price: '2750.00'),
    StockModel(name: 'Facebook, Inc.', symbol: 'FB', price: '330.20'),
    StockModel(name: 'Tesla, Inc.', symbol: 'TSLA', price: '720.80'),
    StockModel(name: 'NVIDIA Corporation', symbol: 'NVDA', price: '620.40'),
    StockModel(name: 'JPMorgan Chase & Co.', symbol: 'JPM', price: '155.30'),
    StockModel(name: 'Johnson & Johnson', symbol: 'JNJ', price: '170.50'),
    StockModel(name: 'Visa Inc.', symbol: 'V', price: '240.90'),
  ];

  Future<List<StockModel>> searchStocks(String query) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    return _mockStocks
        .where((stock) =>
            stock.name.toLowerCase().contains(query.toLowerCase()) ||
            stock.symbol.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<String> getLatestPrice(String symbol) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 300));

    // Simulate price fluctuation
    final stock = _mockStocks.firstWhere((s) => s.symbol == symbol);
    final currentPrice = double.parse(stock.price);
    final fluctuation = (Random().nextDouble() - 0.5) * 5; // +/- 2.5%
    return (currentPrice + fluctuation).toStringAsFixed(2);
  }
}