
import 'package:hive/hive.dart';
import '../models/stock_model.dart';

class LocalStorageService {
  final String boxName = 'watchlist';

  void addStockToWatchlist(StockModel stock) {
    final box = Hive.box<StockModel>(boxName);
    box.put(stock.symbol, stock);
  }

  void removeStockFromWatchlist(StockModel stock) {
    final box = Hive.box<StockModel>(boxName);
    box.delete(stock.symbol);
  }

  List<StockModel> getWatchlist() {
    final box = Hive.box<StockModel>(boxName);
    return box.values.toList();
  }
}