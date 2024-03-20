import 'package:finpay/config/services/local/local_biometric.dart';
import 'package:finpay/data/data_sources/location_service.dart';
import 'package:finpay/data/data_sources/manage_services_service.dart';
import 'package:finpay/data/data_sources/topup_service.dart';
import 'package:finpay/data/data_sources/trade_service.dart';
import 'package:finpay/data/data_sources/transfere_service.dart';
import 'package:finpay/data/data_sources/user_service.dart';
import 'package:finpay/data/repositories/auth_repo.dart';
import 'package:finpay/data/repositories/service_repo.dart';
import 'package:finpay/data/repositories/top_up_repo.dart';
import 'package:finpay/data/repositories/transfere_repo.dart';
import 'package:finpay/data/repositories/user_repo.dart';
import 'package:finpay/data/data_sources/auth_service.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/trade_repo.dart';

final locators = GetIt.instance;

configurationDependencies() {
  locators.registerLazySingleton(
    () => BiometricService(),
  );
  locators.registerLazySingleton(
    () => UserAuthRepo(
      authService: AuthService(),
    ),
  );

  locators.registerLazySingleton(
    () => UserRepo(service: UserServices()),
  );
  locators.registerLazySingleton(
    () => TransferRepo(
      service: TransfereServices(),
    ),
  );
  locators.registerLazySingleton(
    () => ServiceRepo(service: Services()),
  );
  locators.registerLazySingleton(
    () => TraderRepo(
      service: TradeService(),
    ),
  );
  locators.registerLazySingleton(
    () => TopupRepo(
      service: TopupService(),
    ),
  );
  locators.registerLazySingleton<LocationService>(
    () => LocationService(),
  );
}
