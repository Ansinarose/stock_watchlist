import 'package:flutter/material.dart';
import 'package:stock_watchlist/repositories/stock_repositories.dart';
import '../models/stock_model.dart';


import '../services/local_storage_service.dart';

class StockProvider with ChangeNotifier {
  final StockRepository _repository = StockRepository();
  final LocalStorageService _localStorageService = LocalStorageService();

  List<StockModel> _searchResults = [];
  List<StockModel> _watchlist = [];

  List<StockModel> get searchResults => _searchResults;
  List<StockModel> get watchlist => _watchlist;

  StockProvider() {
    _loadWatchlist();
  }

  Future<void> searchStocks(String query) async {
    _searchResults = await _repository.searchStocks(query);
    notifyListeners();
  }

  void addToWatchlist(StockModel stock) {
    _localStorageService.addStockToWatchlist(stock);
    _watchlist.add(stock);
    notifyListeners();
  }

  void removeFromWatchlist(StockModel stock) {
    _localStorageService.removeStockFromWatchlist(stock);
    _watchlist.remove(stock);
    notifyListeners();
  }

  void _loadWatchlist() async {
    _watchlist = _localStorageService.getWatchlist();
    notifyListeners();
  }
}
