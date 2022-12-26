import 'package:firestore_figure_saver/figure_to_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/anchor.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:mocktail/mocktail.dart';

class MockDrawTool extends Mock implements DrawToolInterface {
  @override
  int maxLength = 2;
  @override
  String name = 'test tool';
}

void main() {
  final anchorA = Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.334532);
  final anchorB = Anchor(x: DateTime.utc(2022, 12, 26, 13, 13), y: 1.32946);
  final figure = Figure(MockDrawTool());
  figure.add(anchorA);
  figure.add(anchorB);

  test("Assert figure JSON convertion is correct", () {
    final jsonFigure = FigureToJSON(figure).convert();
    expect(
        jsonFigure,
        equals(<String, dynamic>{
          'name': 'test tool',
          'anchors': [
            {"datetime": DateTime.utc(2022, 12, 26, 12, 46), 'y': 1.334532},
            {"datetime": DateTime.utc(2022, 12, 26, 13, 13), 'y': 1.32946},
          ]
        }));
  });
}
