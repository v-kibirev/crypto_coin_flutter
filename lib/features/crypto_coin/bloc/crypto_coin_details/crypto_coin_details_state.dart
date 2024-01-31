part of 'crypto_coin_details_bloc.dart';

class CryptoCoinDetailsState extends Equatable {
  const CryptoCoinDetailsState();

  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoading extends CryptoCoinDetailsState {
  const CryptoCoinDetailsLoading();
}

class CryptoCoinDetailsLoaded extends CryptoCoinDetailsState {
  final CryptoCoin coin;

  const CryptoCoinDetailsLoaded(this.coin);

  @override
  List<Object?> get props => [coin];
}

class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailsState {
  final Object exception;

  const CryptoCoinDetailsLoadingFailure(this.exception);

  @override
  List<Object?> get props => [exception];
}
