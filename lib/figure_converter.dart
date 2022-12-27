import 'package:firestore_figure_saver/anchor_to_json.dart';
import 'package:grapher_user_draw/figure.dart';

class FigureConverter {
  static Map<String, dynamic> toJSON(Figure figure) {
    final result = <String, dynamic>{
      'name': figure.tool.name,
      'groupID': figure.groupID,
      'length': figure.length
    };
    final anchorList = <Map<String, dynamic>>[];
    for (final anchor in figure.getAll()) {
      anchorList.add(AnchorToJSON(anchor).convert());
    }
    result['anchors'] = anchorList;
    return result;
  }
}
