import 'package:firestore_figure_database/context.dart';
import 'package:firestore_figure_database/figure_converter.dart';
import 'package:firestore_figure_database/initializator.dart';
import 'package:flutter/widgets.dart';
import 'package:grapher_user_draw/anchor.dart';
import 'package:grapher_user_draw/draw_tools/draw_info.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/figure.dart';

import '../main.dart';

class FigureConverterExample extends FigureConverter {
  @override
  DrawToolInterface guessToolUsingItsName(String name) {
    return DrawToolExample();
  }
}

class DrawToolExample implements DrawToolInterface {
  @override
  int maxLength = 2;

  @override
  String name = "atoolexample_2";

  @override
  draw(DrawInfo drawInfo, Figure figure) {
    throw UnimplementedError();
  }
}

void main(List<String> args) {
  runApp(const FirestoreFigureDBExample());
}

// ignore: must_be_immutable
class FirestoreFigureDBExample extends StatefulWidget {
  const FirestoreFigureDBExample({super.key});

  @override
  State<StatefulWidget> createState() => _FirestoreFigureDBExampleState();
}

class _FirestoreFigureDBExampleState extends State<FirestoreFigureDBExample> {
  FirestoreFigureDatabase? figureDB;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    final firestoreInstance = await FirestoreInit.getEmulatorInstance();
    figureDB = FirestoreFigureDatabase(
      firestoreInstance,
      FigureConverterExample(),
      const FigureContext('EUR_USD', 'BROKER_1'),
    );
  }

  @override
  Widget build(BuildContext context) {
    save();
    asyncLoad();
    return const Placeholder();
  }

  void save() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (figureDB == null) return;
    final anchorA = Anchor(x: DateTime(2022, 12, 26, 17, 51), y: 1.324);
    final anchorB = Anchor(x: DateTime(2022, 12, 26, 18, 51), y: 1.374);
    final figure = Figure(DrawToolExample());
    figure.add(anchorA);
    figure.add(anchorB);
    figureDB!.save(figure);
  }

  void asyncLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    final figures = await figureDB?.load();
    debugPrint(figures.toString());
  }
}
