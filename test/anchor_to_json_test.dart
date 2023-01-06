import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_database/anchor_to_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/anchor.dart';

void main() {
  test("Assert anchor JSON convertion is correct", () {
    final anchor = Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.334532);
    final jsonAnchor = AnchorConverter().toJSON(anchor);
    expect(
        jsonAnchor,
        equals(<String, dynamic>{
          "datetime": Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46)),
          "y": 1.334532
        }));
  });
  test("Assert anchor JSON convertion return a datetime in UTC", () {
    final anchor = Anchor(x: DateTime(2022, 12, 26, 13, 46), y: 1.334532);
    final jsonAnchor = AnchorConverter().toJSON(anchor);

    final anchorDatetime = jsonAnchor['datetime'];
    expect(anchorDatetime,
        equals(Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46))));
  });

  test(
      'Assert given a JSON formatted anchor, '
      'an Anchor object is returned', () {
    final jsonAnchor = <String, dynamic>{
      'datetime': Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46)),
      'y': 1.9451
    };
    final resultAnchor = AnchorConverter().fromJSONAnchor(jsonAnchor);
    final expectedAnchor =
        Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.9451);
    expect(resultAnchor, equals(expectedAnchor));
  });

  test("Assert JSON anchor list is converted to object Anchor list", () {
    final jsonAnchorList = <Map<String, dynamic>>[
      {
        'datetime': Timestamp.fromDate(DateTime.utc(2022, 12, 26, 12, 46)),
        'y': 1.2473
      },
      {
        'datetime': Timestamp.fromDate(DateTime.utc(2022, 12, 29, 18, 15)),
        'y': 1.346
      },
    ];
    final resultingList = AnchorConverter().fromJSONAnchorList(jsonAnchorList);
    final expectedList = <Anchor>[
      Anchor(x: DateTime.utc(2022, 12, 26, 12, 46), y: 1.2473),
      Anchor(x: DateTime.utc(2022, 12, 29, 18, 15), y: 1.346)
    ];
    expect(resultingList, equals(expectedList));
  });
}
