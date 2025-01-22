import 'package:ecommerce_app_2/data/repositories/product_repo.dart';
import 'package:ecommerce_app_2/providers/product_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt
    ..registerLazySingleton<ProductRepo>(() => ProductRepo())
    ..registerFactory<ProductProvider>(
        () => ProductProvider(productRepo: getIt()));
}
