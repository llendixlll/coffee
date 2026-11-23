import 'package:coffee/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Меню показує привітання і картки товарів', (tester) async {
    await tester.pumpWidget(const CoffeeApp());

    expect(find.text('Кав\'ярня «Зерно»'), findsOneWidget);
    expect(find.text('Виконав: Коваль Д. В., гр. ІПЗ-42'), findsOneWidget);
    expect(find.text('Капучино'), findsOneWidget);
  });
}
