import 'package:firestore_figure_saver/anchor_to_json.dart';
import 'package:grapher_user_draw/figure.dart';

class FigureToJSON {
  final Figure _figure;
  FigureToJSON(this._figure);

  Map<String, dynamic> convert() {
    final result = <String, dynamic>{
      'name': _figure.tool.name,
      'groupID': _figure.groupID,
      'length': _figure.length
    };
    final anchorList = <Map<String, dynamic>>[];
    for (final anchor in _figure.getAll()) {
      anchorList.add(AnchorToJSON(anchor).convert());
    }
    result['anchors'] = anchorList;
    return result;
  }
}
