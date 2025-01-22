import 'package:ecommerce_app_2/data/repositories/product_repo.dart';
import 'package:ecommerce_app_2/data/services/injection_container.dart';
import 'package:ecommerce_app_2/presentation/screens/products_screen.dart';
import 'package:ecommerce_app_2/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<ProductProvider>()..getProducts(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProductsScreen(),
      ),
    );
  }
}
