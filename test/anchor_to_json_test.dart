import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/anchor_to_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/anchor.dart';

void main() {
  test("Assert anchor JSON convertion is correct", () {
    final anchor = Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.334532);
    final jsonAnchor = AnchorToJSON(anchor).convert();
    expect(
        jsonAnchor,
        equals(<String, dynamic>{
          "datetime": Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46)),
          "y": 1.334532
        }));
  });
  test("Assert anchor JSON convertion return a datetime in UTC", () {
    final anchor = Anchor(x: DateTime(2022, 12, 26, 13, 46), y: 1.334532);
    final jsonAnchor = AnchorToJSON(anchor).convert();

    final anchorDatetime = jsonAnchor['datetime'];
    // expect(anchorDatetime.toString(), endsWith('Z'));
    expect(anchorDatetime,
        equals(Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46))));
  });
}
