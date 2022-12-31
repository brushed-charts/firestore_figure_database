import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';

class FirestoreFigureDatabase implements FigureDatabaseInterface {
  static const collectionPath = 'grapher_figure';
  final FirebaseFirestore firestore;
  final FigureConverter _figureConverter;
  late final CollectionReference<Figure?> figureCollectionRef;

  FirestoreFigureDatabase(this.firestore, this._figureConverter) {
    figureCollectionRef = firestore.collection(collectionPath).withConverter(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
      final figureJSON = snapshot.data();
      if (figureJSON == null) return null;
      return _figureConverter.fromJSON(figureJSON);
    }, toFirestore: (Figure? figure, _) {
      if (figure == null) return {};
      return _figureConverter.toJSON(figure);
    });
  }

  @override
  void delete(Figure figureToDelete) {
    firestore
        .collection(collectionPath)
        .doc(figureToDelete.groupID.toString())
        .delete();
  }

  @override
  Future<List<Figure>> load() async {
    final snapshot = await figureCollectionRef.get();
    final figures = snapshot.docs.map((e) => e.data()).toList();
    figures.removeWhere((figure) => figure == null);
    return figures.cast<Figure>();
  }

  @override
  void save(Figure newFigure) {
    figureCollectionRef.doc(newFigure.groupID.toString()).set(newFigure);
  }
}
