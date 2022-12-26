import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/firestore_instance.dart';
import 'package:grapher_user_draw/figure.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';

class FirestoreFigureSaver implements FigureDatabaseInterface {
  late final _firestore = FirestoreInstance(useEmulator: true).getInstance;

  @override
  void delete(Figure figureToDelete, List<Figure> allFigures) {}

  @override
  List<Figure> load() {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  void save(Figure newFigure, List<Figure> allFigures) {}
}
