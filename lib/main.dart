import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/context.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:firestore_figure_saver/firestore_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';
import 'package:logging/logging.dart';

class FirestoreFigureDatabase implements FigureDatabaseInterface {
  static const collectionPath = 'grapher_figure';
  final FirebaseFirestore? _firestoreInstance;
  CollectionReference<Figure?>? _figureCollectionRef;

  final _logger = Logger('FirestoreFigureDatabase');
  final FigureConverter _figureConverter;
  FigureContext context;

  FirestoreFigureDatabase(
      this._firestoreInstance, this._figureConverter, this.context) {
    _logger.onRecord.listen((record) {
      debugPrint("${record.loggerName}: ${record.level.name}, "
          "${record.time.toUtc()}, ${record.message}");
    });
    _initCollectionReference();
  }

  void _initCollectionReference() {
    _figureCollectionRef = _firestoreInstance!
        .collection(collectionPath)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                FirestoreConverter.fromDB(_figureConverter, snapshot),
            toFirestore: (figure, _) =>
                FirestoreConverter.toDB(_figureConverter, context, figure));
  }

  @override
  void delete(Figure figureToDelete) {
    if (_firestoreInstance == null || _figureCollectionRef == null) {
      _logger.severe("Can't delete the figure,because firestore "
          "instance is null, maybe it is not initialized yet");
      return;
    }
    _figureCollectionRef!.doc(figureToDelete.groupID.toString()).delete();
  }

  @override
  Future<List<Figure>> load() async {
    if (_firestoreInstance == null || _figureCollectionRef == null) {
      _logger.severe("Can't load the figure, because firestore "
          "instance is null, maybe it is not initialized yet");
      return [];
    }
    final snapshot = await _figureCollectionRef!
        .where('context.asset_pair', isEqualTo: context.assetPair)
        .get();
    final figures = snapshot.docs.map((e) => e.data()).toList();
    figures.removeWhere((figure) => figure == null);
    return figures.cast<Figure>();
  }

  @override
  void save(Figure newFigure) {
    if (_firestoreInstance == null || _figureCollectionRef == null) {
      _logger.severe("Can't save the figure, because firestore "
          "instance is null, maybe it is not initialized yet");
      return;
    }
    _figureCollectionRef!.doc(newFigure.groupID.toString()).set(newFigure);
  }
}
