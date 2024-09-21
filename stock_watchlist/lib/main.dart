
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_watchlist/screens/home_screen.dart';
import 'package:stock_watchlist/screens/splash_screen.dart';

import 'models/stock_model.dart';
import 'providers/stock_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StockModelAdapter());
  await Hive.openBox<StockModel>('watchlist');
  await Hive.openBox<List<dynamic>>('stockSearchCache');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StockProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock Watchlist',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
