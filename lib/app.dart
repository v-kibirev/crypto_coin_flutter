import 'package:coins/router/router.dart';
import 'package:coins/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final MainNavigation mainNavigation;
  const App({
    super.key,
    required this.mainNavigation,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: darkTheme,
      routes: mainNavigation.routes,
      initialRoute: RoutesList.main.path,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
