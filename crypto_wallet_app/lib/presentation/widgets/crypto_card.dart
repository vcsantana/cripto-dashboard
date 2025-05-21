import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CryptoCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String price;
  final String percentChange;
  final String iconUrl;
  final Color percentColor;

  const CryptoCard({
    Key? key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.percentChange,
    required this.iconUrl,
    required this.percentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 22,
              child: CachedNetworkImage(
                imageUrl: iconUrl,
                width: 32,
                height: 32,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.monetization_on, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  Text(symbol, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: Theme.of(context).textTheme.titleMedium),
                Text(percentChange,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: percentColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
