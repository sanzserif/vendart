import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';
import 'core/utils/input_converter.dart';
import 'features/pos_checkout/data/datasources/checkout_local_datasource.dart';
import 'features/pos_checkout/data/repositories/checkout_repository_impl.dart';
import 'features/pos_checkout/domain/repositories/checkout_repository.dart';
import 'features/pos_checkout/domain/usecases/add_item_to_cart.dart';
import 'features/pos_checkout/domain/usecases/get_checkout_items.dart';
import 'features/pos_checkout/domain/usecases/process_checkout.dart';
import 'features/pos_checkout/presentation/bloc/checkout_bloc.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  //! Features - POS Checkout
  // Bloc
  sl.registerFactory(
    () => CheckoutBloc(
      getCheckoutItems: sl(),
      addItemToCart: sl(),
      processCheckout: sl(),
      repository: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCheckoutItems(sl()));
  sl.registerLazySingleton(() => AddItemToCart(sl()));
  sl.registerLazySingleton(() => ProcessCheckout(sl()));

  // Repository
  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CheckoutLocalDataSource>(
    () => CheckoutLocalDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton(() => InputConverter());
}
