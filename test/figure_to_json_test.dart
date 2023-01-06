import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_database/context.dart';
import 'package:firestore_figure_database/figure_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/anchor.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:mocktail/mocktail.dart';

class MockDrawTool extends Mock implements DrawToolInterface {
  MockDrawTool(this.maxLength) : name = 'testtool_$maxLength';
  @override
  int maxLength = 2;
  @override
  String name;
}

class FakeFigureConverter extends FigureConverter {
  @override
  DrawToolInterface guessToolUsingItsName(String name) {
    final figureLen = int.parse(name.split('_')[1]);
    return MockDrawTool(figureLen);
  }
}

void main() {
  final anchorA = Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.334532);
  final anchorB = Anchor(x: DateTime.utc(2022, 12, 26, 13, 13), y: 1.32946);
  final baseFigure = Figure(MockDrawTool(2));
  baseFigure.add(anchorA);
  baseFigure.add(anchorB);
  const context = FigureContext('EUR_USD', 'BROKER_1');

  final expectedJsonFigure = <String, dynamic>{
    'tool_name': 'testtool_2',
    'group_id': baseFigure.groupID,
    'length': baseFigure.length,
    'context': {'asset_pair': 'EUR_USD', 'broker': 'BROKER_1'},
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
    final jsonFigure = FakeFigureConverter().toJSON(baseFigure, context);
    expect(jsonFigure, equals(expectedJsonFigure));
  });

  test("Assert figure can be read from JSON", () {
    final resultingFigure = FakeFigureConverter().fromJSON(expectedJsonFigure);
    expect(resultingFigure, equals(baseFigure));
  });
}
