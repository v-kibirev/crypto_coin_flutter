part of 'crypto_coin_details_bloc.dart';

sealed class CryptoCoinDetailsEvent extends Equatable {
  const CryptoCoinDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCryptoCoinDetails extends CryptoCoinDetailsEvent {
  const LoadCryptoCoinDetails({
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  List<Object> get props => [currencyCode];
}
