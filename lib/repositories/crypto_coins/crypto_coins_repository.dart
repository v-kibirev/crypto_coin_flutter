import 'package:coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CryptoCoinRepository implements InterfaceCryptoCoinRepository {
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  CryptoCoinRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var coinList = <CryptoCoin>[];

    try {
      coinList = await _fetchCoinsListFromApi();
      final Map<String, CryptoCoin> coinsMap = {for (var e in coinList) e.name: e};
      await cryptoCoinsBox.putAll(coinsMap);
    } catch (e) {
      return cryptoCoinsBox.values.toList();
    }

    return coinList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,BNB,ETH,ADA,SLP,USDT,XRP,SOL,DOGE,TRX&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinList = dataRaw.entries.map(
      (coin) {
        final usdData = (coin.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
        final details = CryptoCoinDetails.fromJson(usdData);
        return CryptoCoin(name: coin.key, details: details);
      },
    ).toList();
    return coinList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      await cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e) {
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
    final response =
        await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetails.fromJson(usdData);
    return CryptoCoin(
      name: currencyCode,
      details: details,
    );
  }
}
