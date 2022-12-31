import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grapher_user_draw/anchor.dart';

class AnchorConverter {
  Map<String, dynamic> toJSON(Anchor anchor) {
    return <String, dynamic>{
      "datetime": Timestamp.fromDate(anchor.x.toUtc()),
      "y": anchor.y
    };
  }

  Anchor fromJSONAnchor(Map<String, dynamic> jsonAnchor) {
    final x = (jsonAnchor['datetime'] as Timestamp).toDate().toUtc();
    final y = jsonAnchor['y'] as double;
    return Anchor(x: x, y: y);
  }

  List<Anchor> fromJSONAnchorList(List<dynamic> jsonAnchorList) {
    final resultingAnchorList = <Anchor>[];
    for (final jsonAnchor in jsonAnchorList) {
      resultingAnchorList.add(fromJSONAnchor(jsonAnchor));
    }
    return resultingAnchorList;
  }
}
