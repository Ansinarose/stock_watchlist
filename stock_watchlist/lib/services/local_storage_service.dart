import 'package:hive/hive.dart';
import '../models/stock_model.dart';

class LocalStorageService {
  Box<StockModel> get _watchlistBox => Hive.box<StockModel>('watchlist');

  List<StockModel> getWatchlist() {
    return _watchlistBox.values.toList();
  }

  void addStockToWatchlist(StockModel stock) {
    _watchlistBox.put(stock.symbol, stock);
  }

  void removeStockFromWatchlist(StockModel stock) {
    _watchlistBox.delete(stock.symbol);
  }
}
