import 'package:firestore_figure_saver/context.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Check if figure context to JSON is conform", () {
    final context = FigureContext("EUR_USD");
    expect(context.toJSON(), equals({'asset_pair': 'EUR_USD'}));
  });
}
