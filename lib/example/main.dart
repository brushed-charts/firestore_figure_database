import 'package:flutter/widgets.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:mocktail/mocktail.dart';

void main(List<String> args) {
  runApp(FirestoreFigureDBExample());
}

class MockDrawTool extends Mock implements DrawToolInterface {
  @override
  int maxLength = 2;
  @override
  String name = 'test tool';
}

class FirestoreFigureDBExample extends StatelessWidget {
  // final saver = FirestoreFigureDatabase();
  FirestoreFigureDBExample({super.key});

  @override
  Widget build(BuildContext context) {
    // save();
    return const Placeholder();
  }

  // void save() async {
  //   await saver.initApp();
  //   final anchorA = Anchor(x: DateTime(2022, 12, 26, 17, 51), y: 1.324);
  //   final anchorB = Anchor(x: DateTime(2022, 12, 26, 18, 51), y: 1.374);
  //   final figure = Figure(MockDrawTool());
  //   figure.add(anchorA);
  //   figure.add(anchorB);
  //   saver.save(figure, [figure]);
  // }
}
