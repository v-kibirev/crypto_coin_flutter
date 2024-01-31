import 'package:coins/repositories/crypto_coins/crypto_coins.dart';

abstract interface class InterfaceCryptoCoinRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinDetails(String currencyCode);
}
