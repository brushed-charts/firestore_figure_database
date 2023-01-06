import 'package:firestore_figure_database/context.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Check if figure context to JSON is conform", () {
    final context = FigureContext("EUR_USD", 'BROKER_1');
    expect(context.toJSON(),
        equals({'asset_pair': 'EUR_USD', 'broker': 'BROKER_1'}));
  });
}
