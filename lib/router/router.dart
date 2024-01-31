import 'package:coins/features/crypto_coin/bloc/crypto_coin_details/crypto_coin_details_bloc.dart';
import 'package:coins/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:coins/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins/features/crypto_list/crypto_list.dart';
import 'package:coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

enum RoutesList {
  main('/'),
  coin('/coin');

  const RoutesList(this.path);
  final String path;
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    RoutesList.main.path: (context) {
      return BlocProvider(
        create: (context) => CryptoListBloc(GetIt.I<InterfaceCryptoCoinRepository>())..initialize(),
        child: const CryptoListScreen(),
      );
    }
  };
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    if (RoutesList.coin.path == settings.name) {
      final coinName = arguments is String ? arguments : '...';
      return MaterialPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => CryptoCoinDetailsBloc(GetIt.I<InterfaceCryptoCoinRepository>())..initialize(coinName),
          child: CryptoCoinScreen(coinName: coinName),
        );
      });
    } else {
      return MaterialPageRoute(builder: (BuildContext context) {
        return const Text('Error page');
      });
    }
  }
}
