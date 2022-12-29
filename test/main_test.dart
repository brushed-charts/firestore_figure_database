import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:firestore_figure_saver/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapher_user_draw/anchor.dart';
import 'package:grapher_user_draw/figure.dart';

import 'figure_to_json_test.dart';

void main() {
  final anchorA = Anchor(x: DateTime(2022, 12, 26, 17, 51), y: 1.324);
  final anchorB = Anchor(x: DateTime(2022, 12, 26, 18, 51), y: 1.374);
  final anchorC = Anchor(x: DateTime(2022, 12, 26, 18, 51), y: 1.421);
  final anchorD = Anchor(x: DateTime(2022, 12, 26, 19, 21), y: 1.362);
  late FakeFirebaseFirestore fakeFirestore;
  late Figure figureA;
  late Figure figureB;
  late FirestoreFigureDatabase figureDB;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    figureA = Figure(MockDrawTool(2));
    figureA.add(anchorA);
    figureA.add(anchorB);

    figureB = Figure(MockDrawTool(3));
    figureB.add(anchorB);
    figureB.add(anchorC);
    figureB.add(anchorD);

    figureDB = FirestoreFigureDatabase(fakeFirestore);
  });

  // group("Firestore save: ", () {
  //   test("Assert firestore document is named using figure groupID", () async {
  //     figureDB.save(figureA, [figureA]);
  //     final jsonFigure = FigureConverter.toJSON(figureA);
  //     final snapshot = await fakeFirestore
  //         .collection(FirestoreFigureDatabase.collectionPath)
  //         .doc(figureA.groupID.toString())
  //         .get();
  //     expect(snapshot.data(), jsonFigure);
  //   });

  //   test("Check that save function, write data in the database", () async {
  //     final jsonFigure = FigureConverter.toJSON(figureA);
  //     figureDB.save(figureA, [figureA]);
  //     final snapshot = await fakeFirestore
  //         .collection(FirestoreFigureDatabase.collectionPath)
  //         .get();
  //     expect(snapshot.docs.length, equals(1));
  //     expect(snapshot.docs.first.data(), equals(jsonFigure));
  //   });

  //   test("Assert figure with the same groupID is updated not added", () async {
  //     figureDB.save(figureA, [figureA]);
  //     figureDB.save(figureB, [figureA, figureB]);
  //     figureA.replace(anchorA, anchorC);
  //     figureDB.save(figureA, [figureA, figureB]);
  //     final jsonWithNewAnchor = FigureConverter.toJSON(figureA);
  //     final jsonFigureB = FigureConverter.toJSON(figureB);
  //     final snapshot = await fakeFirestore
  //         .collection(FirestoreFigureDatabase.collectionPath)
  //         .get();
  //     expect(snapshot.docs.length, equals(2));
  //     expect(snapshot.docs.first.data(), equals(jsonWithNewAnchor));
  //     expect(snapshot.docs.last.data(), equals(jsonFigureB));
  //   });
  // });

  // group("Firestore delete: ", () {
  //   test("Assert figure is deleted from database", () async {
  //     figureDB.save(figureA, [figureA]);
  //     figureDB.delete(figureA, []);
  //     final docCount = (await fakeFirestore
  //             .collection(FirestoreFigureDatabase.collectionPath)
  //             .get())
  //         .size;
  //     expect(docCount, equals(0));
  //   });

  //   test("Expect deletion of non existing figure do nothing", () async {
  //     figureDB.save(figureA, [figureA]);
  //     final nonSavedFigure = Figure(MockDrawTool(1));
  //     final jsonFigureA = FigureConverter.toJSON(figureA);
  //     figureDB.delete(nonSavedFigure, [figureA]);

  //     final snapshot = await fakeFirestore
  //         .collection(FirestoreFigureDatabase.collectionPath)
  //         .get();
  //     expect(snapshot.docs.length, equals(1));
  //     expect(snapshot.docs.first.data(), equals(jsonFigureA));
  //   });
  // });

  // group("Firestore load: ", () {
  //   // test("Assert saved figure can be loaded", () async {
  //   //   figureDB.save(figureA, [figureA]);
  //   //   figureDB.save(figureB, [figureA, figureB]);
  //   //   final figures = figureDB.load();
  //   //   expect(figures.length, equals(2));
  //   //   expect(figures.contains(figureA), isTrue);
  //   //   expect(figures.contains(figureB), isTrue);
  //   // });
  // });
}
