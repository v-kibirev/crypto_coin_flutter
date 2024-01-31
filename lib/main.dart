import 'package:coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins/router/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:coins/app.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  const cryptoCoinsBoxName = 'crypto_coin_box';
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailsAdapter());
  final cryproCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  GetIt.I.registerLazySingleton<InterfaceCryptoCoinRepository>(
    () => CryptoCoinRepository(
      dio: Dio(),
      cryptoCoinsBox: cryproCoinsBox,
    ),
  );
  GetIt.I.registerLazySingleton<MainNavigation>(
    () => MainNavigation(),
  );

  runApp(App(
    mainNavigation: GetIt.I<MainNavigation>(),
  ));
}
