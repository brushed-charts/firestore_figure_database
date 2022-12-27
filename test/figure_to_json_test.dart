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

void main() {
  final anchorA = Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.334532);
  final anchorB = Anchor(x: DateTime.utc(2022, 12, 26, 13, 13), y: 1.32946);
  final figure = Figure(MockDrawTool(2));
  figure.add(anchorA);
  figure.add(anchorB);

  test("Assert figure JSON convertion is correct", () {
    final jsonFigure = FigureConverter(figure).toJSON();
    expect(
        jsonFigure,
        equals(<String, dynamic>{
          'name': 'test tool',
          'groupID': figure.groupID,
          'length': figure.length,
          'anchors': [
            {
              "datetime":
                  Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46)),
              'y': 1.334532
            },
            {
              "datetime":
                  Timestamp.fromDate(DateTime.utc(2022, 12, 26, 13, 13)),
              'y': 1.32946
            },
          ]
        }));
  });
}
