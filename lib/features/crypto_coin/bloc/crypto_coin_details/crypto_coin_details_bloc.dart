import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';

part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  final InterfaceCryptoCoinRepository coinsRepository;
  CryptoCoinDetailsBloc(this.coinsRepository) : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);
  }
  Future<void> _load(
    LoadCryptoCoinDetails event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    try {
      if (state is! CryptoCoinDetailsLoaded) {
        emit(const CryptoCoinDetailsLoading());
      }

      final coinDetails = await coinsRepository.getCoinDetails(event.currencyCode);

      emit(CryptoCoinDetailsLoaded(coinDetails));
    } catch (e) {
      emit(CryptoCoinDetailsLoadingFailure(e));
    }
  }

  initialize(String currencyCode) {
    add(LoadCryptoCoinDetails(currencyCode: currencyCode));
  }
}
