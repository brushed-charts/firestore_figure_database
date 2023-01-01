import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/context.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';

class FirestoreFigureDatabase implements FigureDatabaseInterface {
  static const collectionPath = 'grapher_figure';
  final FirebaseFirestore _firestore;
  final FigureConverter _figureConverter;
  late final CollectionReference<Figure?> _figureCollectionRef;
  FigureContext context;

  FirestoreFigureDatabase(
      this._firestore, this._figureConverter, this.context) {
    _figureCollectionRef = _firestore.collection(collectionPath).withConverter(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
      final figureJSON = snapshot.data();
      if (figureJSON == null) return null;
      return _figureConverter.fromJSON(figureJSON);
    }, toFirestore: (Figure? figure, _) {
      if (figure == null) return {};
      return _figureConverter.toJSON(figure, context);
    });
  }

  @override
  void delete(Figure figureToDelete) {
    _firestore
        .collection(collectionPath)
        .doc(figureToDelete.groupID.toString())
        .delete();
  }

  @override
  Future<List<Figure>> load() async {
    final snapshot = await _figureCollectionRef
        .where('context.asset_pair', isEqualTo: context.assetPair)
        .get();
    final figures = snapshot.docs.map((e) => e.data()).toList();
    figures.removeWhere((figure) => figure == null);
    return figures.cast<Figure>();
  }

  @override
  void save(Figure newFigure) {
    _figureCollectionRef.doc(newFigure.groupID.toString()).set(newFigure);
  }
}
