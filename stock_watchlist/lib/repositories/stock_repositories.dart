// import '../models/stock_model.dart';
// import '../services/api_service.dart';

// class StockRepository {
//   final ApiService _apiService = ApiService();

//   Future<List<StockModel>> searchStocks(String query) async {
//     return await _apiService.fetchStockData(query);
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/stock_model.dart';

class StockRepository {
  final String apiKey = 'WYMOSJXVLA17A5QB'; // Your API key
  final String baseUrl = 'https://www.alphavantage.co/query';
  final String cacheBoxName = 'stockSearchCache';

  Future<List<StockModel>> searchStocks(String query) async {
    var box = await Hive.openBox<List<dynamic>>(cacheBoxName);
    List<dynamic>? cachedData = box.get(query);
    
    if (cachedData != null) {
      print('Returning cached data for query: $query');
      return cachedData.map((item) => StockModel.fromJson(Map<String, dynamic>.from(item))).toList();
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl?function=SYMBOL_SEARCH&keywords=$query&apikey=$apiKey')
      );

      print('API Response Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic>? matches = data['bestMatches'];
        
        if (matches == null) {
          print('API returned null for bestMatches');
          return [];
        }
        
        List<StockModel> results = matches.map((match) => StockModel(
          name: match['2. name'] ?? 'Unknown',
          symbol: match['1. symbol'] ?? 'Unknown',
          price: 'N/A',
        )).toList();

        await box.put(query, results.map((e) => e.toJson()).toList());
        
        return results;
      } else {
        throw Exception('Failed to load stock data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in searchStocks: $e');
      return [];
    } finally {
      await box.close();
    }
  }

  Future<String> getLatestPrice(String symbol) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['Global Quote']['05. price'] ?? 'N/A';
      } else {
        throw Exception('Failed to load price data');
      }
    } catch (e) {
      print('Error getting latest price: $e');
      return 'N/A';
    }
  }

  Future<void> clearCache() async {
    var box = await Hive.openBox<List<dynamic>>(cacheBoxName);
    await box.clear();
    await box.close();
  }
}