import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/context.dart';
import 'package:firestore_figure_saver/figure_converter.dart';
import 'package:grapher_user_draw/figure.dart';

class FirestoreConverter {
  static fromDB(FigureConverter figureConverter,
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final figureJSON = snapshot.data();
    if (figureJSON == null) return null;
    return figureConverter.fromJSON(figureJSON);
  }

  static toDB(
      FigureConverter figureConverter, FigureContext context, Figure? figure) {
    if (figure == null) return {};
    return figureConverter.toJSON(figure, context);
  }
}
