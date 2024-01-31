import 'dart:async';

import 'package:coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final InterfaceCryptoCoinRepository cryptoCoinRepository;
  CryptoListBloc(this.cryptoCoinRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }
        final crtptoCoinList = await cryptoCoinRepository.getCoinsList();
        emit(CryptoListLoaded(coinsList: crtptoCoinList));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
  void initialize() {
    add(LoadCryptoList());
  }
}
