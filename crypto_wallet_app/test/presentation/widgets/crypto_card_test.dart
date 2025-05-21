import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_wallet_app/presentation/widgets/crypto_card.dart';

void main() {
  testWidgets('CryptoCard exibe dados corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CryptoCard(
          name: 'Bitcoin',
          symbol: 'BTC',
          price: '1000',
          percentChange: '-2.5%',
          iconUrl: '',
          percentColor: Colors.red,
        ),
      ),
    );

    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('BTC'), findsOneWidget);
    expect(find.text('1000'), findsOneWidget);
    expect(find.text('-2.5%'), findsOneWidget);
    final percentText = tester.widget<Text>(find.text('-2.5%'));
    expect(percentText.style?.color, Colors.red);
  });
}
