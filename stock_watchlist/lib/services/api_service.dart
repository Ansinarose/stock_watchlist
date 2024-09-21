import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_watchlist/models/stock_model.dart';

class ApiService {
  final String _apiKey = 'YOUR_API_KEY';

  Future<List<StockModel>> fetchStockData(String query) async {
    final response = await http.get(
      Uri.parse('https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$query&apikey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['bestMatches'] != null) {
        // Ensure 'bestMatches' exists before trying to map over it
        List<StockModel> stocks = (jsonResponse['bestMatches'] as List).map((data) {
          return StockModel(
            name: data['2. name'] ?? 'Unknown Name',        // Fallback for null values
            symbol: data['1. symbol'] ?? 'Unknown Symbol',
            price: data['05. price'] ?? '0.00',
          );
        }).toList();

        return stocks;
      } else {
        // Handle case where 'bestMatches' is null or empty
        return [];
      }
    } else {
      throw Exception('Failed to fetch stock data');
    }
  }
}