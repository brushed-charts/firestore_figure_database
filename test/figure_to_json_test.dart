import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/anchor.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:mocktail/mocktail.dart';

class MockDrawTool extends Mock implements DrawToolInterface {
  MockDrawTool(this.maxLength);
  @override
  int maxLength = 2;
  @override
  String name = 'test tool';
}

class FakeFigureConverter extends FigureConverter {
  @override
  DrawToolInterface guessToolUsingItsName(String name) {
    return MockDrawTool(2);
  }
}

void main() {
  final anchorA = Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.334532);
  final anchorB = Anchor(x: DateTime.utc(2022, 12, 26, 13, 13), y: 1.32946);
  final figure = Figure(MockDrawTool(2));
  figure.add(anchorA);
  figure.add(anchorB);

  final expectedJsonFigure = <String, dynamic>{
    'tool_name': 'test tool',
    'group_id': figure.groupID,
    'length': figure.length,
    'anchors': [
      {
        "datetime": Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46)),
        'y': 1.334532
      },
      {
        "datetime": Timestamp.fromDate(DateTime.utc(2022, 12, 26, 13, 13)),
        'y': 1.32946
      },
    ]
  };

  test("Assert figure can be wrote to JSON", () {
    final jsonFigure = FakeFigureConverter().toJSON(figure);
    expect(jsonFigure, equals(expectedJsonFigure));
  });

  test("Assert figure can be read from JSON", () {
    final resultingFigure = FakeFigureConverter().fromJSON(expectedJsonFigure);
    expect(resultingFigure, equals(figure));
  });
}
