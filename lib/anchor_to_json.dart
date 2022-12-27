import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grapher_user_draw/anchor.dart';

class AnchorToJSON {
  final Anchor _anchor;
  AnchorToJSON(this._anchor);

  Map<String, dynamic> convert() {
    return <String, dynamic>{
      "datetime": Timestamp.fromDate(_anchor.x.toUtc()),
      "y": _anchor.y
    };
  }
}
