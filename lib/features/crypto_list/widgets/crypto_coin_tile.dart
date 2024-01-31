import 'package:coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins/router/router.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(
        coin.details.fullImageUrl,
        loadingBuilder: (context, child, stackTrack) {
          if (stackTrack == null) return child;
          return const CircularProgressIndicator();
        },
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: 40,
            height: 40,
            child: Placeholder(),
          );
        },
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        coin.details.priceInUSD.toString(),
        style: theme.textTheme.labelSmall,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          RoutesList.coin.path,
          arguments: coin.name,
        );
      },
    );
  }
}
