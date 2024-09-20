import 'package:hive/hive.dart';

part 'stock_model.g.dart'; // Required for Hive type adapter generation

@HiveType(typeId: 0) // Hive annotation for type registration
class StockModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String symbol;

  @HiveField(2)
  final String price;

  StockModel({
    required this.name,
    required this.symbol,
    required this.price,
  });
}
