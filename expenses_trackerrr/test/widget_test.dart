import 'package:expense_tracker/expenses.dart'; // Expenses widget'ı test ediliyor.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Uygulamanızın ana widget'ını pumpWidget ile yükleyin.
    await tester.pumpWidget(const MaterialApp(home: Expenses()));

    // Sayacın başlangıçta 0 olup olmadığını doğrulayın.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // '+' simgesine tıklayın ve bir frame tetikleyin.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Sayaç 1'e yükselmiş olmalı.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
