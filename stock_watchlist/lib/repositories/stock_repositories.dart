import '../models/stock_model.dart';
import '../services/api_service.dart';

class StockRepository {
  final ApiService _apiService = ApiService();

  Future<List<StockModel>> searchStocks(String query) async {
    return await _apiService.fetchStockData(query);
  }
}
