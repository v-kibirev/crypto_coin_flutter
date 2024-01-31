// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coins/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins/features/crypto_list/widgets/widgets.dart';

class CryptoListScreen extends StatelessWidget {
  const CryptoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Coin List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          BlocProvider.of<CryptoListBloc>(context).add(LoadCryptoList(completer: completer));

          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.coinsList.length,
                itemBuilder: (BuildContext context, int index) {
                  final coin = state.coinsList[index];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong!'),
                    OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<CryptoListBloc>(context).add(LoadCryptoList());
                      },
                      child: const Text('Try again'),
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
