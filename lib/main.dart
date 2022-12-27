import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/figure_to_json.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';

class FirestoreFigureDatabase implements FigureDatabaseInterface {
  static const collectionPath = 'grapher_figure';
  final FirebaseFirestore firestore;
  FirestoreFigureDatabase(this.firestore);

  @override
  void delete(Figure figureToDelete, List<Figure> allFigures) {
    firestore
        .collection(collectionPath)
        .doc(figureToDelete.groupID.toString())
        .delete();
  }

  @override
  List<Figure> load() {
    return [];
  }

  @override
  void save(Figure newFigure, List<Figure> allFigures) {
    final jsonFigure = FigureToJSON(newFigure).convert();
    firestore
        .collection(collectionPath)
        .doc(newFigure.groupID.toString())
        .set(jsonFigure);
  }
}
