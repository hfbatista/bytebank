import 'package:bytebank_persistencia/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  testWidgets('should display the main screen when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  
  testWidgets('Should display the transfer feature when the Dashboard is opened', (tester) async{
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transferFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, 'Transfer', Icons.monetization_on);
    });
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the transaction feed feature when the Dashboard is opened', (tester) async{
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.description);
    expect(iconTransferFeatureItem, findsOneWidget);
    final nametransferFeatureItem = find.widgetWithText(FeatureItem, 'Transaction Feed');
    expect(nametransferFeatureItem, findsOneWidget);
  });
}