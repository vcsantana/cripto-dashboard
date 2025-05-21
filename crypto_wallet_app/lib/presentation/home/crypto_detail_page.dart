import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/crypto.dart';

class CryptoDetailPage extends StatelessWidget {
  final Crypto crypto;
  const CryptoDetailPage({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(crypto.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                crypto.iconUrl,
                width: 64,
                height: 64,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.monetization_on, size: 64),
              ),
            ),
            const SizedBox(height: 24),
            Text('${l10n.profile}: ${crypto.symbol}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text('${l10n.home}: ${crypto.price}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text('${l10n.details}: ${crypto.percentChange}',
                style: Theme.of(context).textTheme.bodyMedium),
            // Adicione mais detalhes conforme necessário
          ],
        ),
      ),
    );
  }
}
