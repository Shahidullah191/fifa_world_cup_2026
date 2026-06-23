import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:fifa_2026/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Fifa2026App());
    await tester.pump();
    expect(GetMaterialApp, findsOneWidget);
  });
}
