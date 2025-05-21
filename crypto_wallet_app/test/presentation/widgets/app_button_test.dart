import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_wallet_app/presentation/widgets/app_button.dart';

void main() {
  testWidgets('AppButton exibe label e chama onPressed',
      (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Entrar',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Entrar'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(pressed, isTrue);
  });
}
