import 'package:coins/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
class CryptoCoin extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final CryptoCoinDetails details;

  const CryptoCoin({
    required this.details,
    required this.name,
  });

  @override
  List<Object> get props => [name, details];
}
