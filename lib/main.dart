import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';

class FirestoreFigureDatabase implements FigureDatabaseInterface {
  static const collectionPath = 'grapher_figure';
  final FirebaseFirestore firestore;
  // late final figureCollectionRef;
  FirestoreFigureDatabase(this.firestore);
  // : figureCollectionRef = this
  //       .firestore
  //       .collection(collectionPath)
  //       .withConverter(
  //           fromFirestore: fromFirestore, toFirestore: toFirestore);

  @override
  void delete(Figure figureToDelete, List<Figure> allFigures) {
    firestore
        .collection(collectionPath)
        .doc(figureToDelete.groupID.toString())
        .delete();
  }

  @override
  List<Figure> load() {
    // final snapshot = await firestore.collection(collectionPath).get();
    // final figures = snapshot.docs.map((e) => e.data()).toList(growable: false);
    // return figures;
    return [];
  }

  @override
  void save(Figure newFigure, List<Figure> allFigures) {
    final jsonFigure = FigureConverter(newFigure).toJSON();
    firestore
        .collection(collectionPath)
        .doc(newFigure.groupID.toString())
        .set(jsonFigure);
  }
}
