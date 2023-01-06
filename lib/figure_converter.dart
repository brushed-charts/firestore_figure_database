import 'package:firestore_figure_database/anchor_to_json.dart';
import 'package:firestore_figure_database/context.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/figure.dart';

abstract class FigureConverter {
  Map<String, Object?> toJSON(Figure figure, FigureContext context) {
    final result = <String, dynamic>{
      'tool_name': figure.type,
      'group_id': figure.groupID,
      'length': figure.length,
      'context': context.toJSON(),
    };
    final anchorList = <Map<String, dynamic>>[];
    for (final anchor in figure.getAll()) {
      anchorList.add(AnchorConverter().toJSON(anchor));
    }
    result['anchors'] = anchorList;
    return result;
  }

  DrawToolInterface guessToolUsingItsName(String name);

  Figure fromJSON(Map<String, dynamic> json) {
    final figureType = json['tool_name'];
    final drawTool = guessToolUsingItsName(figureType);
    final convertedFigure = Figure(drawTool, json['group_id']);
    final anchors = AnchorConverter().fromJSONAnchorList(json['anchors']);
    for (final anchorToAdd in anchors) {
      convertedFigure.add(anchorToAdd);
    }
    return convertedFigure;
  }
}
