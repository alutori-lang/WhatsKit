import 'package:flutter_test/flutter_test.dart';
import 'package:whatskit/main.dart';

void main() {
  testWidgets('App boots and shows WhatsKit title', (WidgetTester tester) async {
    await tester.pumpWidget(const WhatsKitApp());
    await tester.pumpAndSettle();
    expect(find.text('WhatsKit'), findsOneWidget);
  });
}
