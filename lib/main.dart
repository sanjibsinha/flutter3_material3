import 'package:dynamic_color/dynamic_color.dart';
import 'package:e_commerce_app/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/products.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

final settings = ValueNotifier(
  ThemeSettings(
    sourceColor: Colors.yellow.shade900,
    themeMode: ThemeMode.system,
  ),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Products(),
      builder: (context, _) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => ThemeProvider(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
          settings: settings,
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    return MaterialApp(
      title: 'MyShop',
      theme: theme.dark(settings.value.sourceColor),
      home: const ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
      },
    );
  }
}
