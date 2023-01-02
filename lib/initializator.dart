import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'firebase_options.dart';

class FirestoreInit {
  static final _logger = Logger('FirestoreInit');

  static _initLogger() {
    _logger.onRecord.listen((record) {
      debugPrint("${record.loggerName}: ${record.level.name}, "
          "${record.time.toUtc()}, ${record.message}");
    });
  }

  static Future<void> _initApp() async {
    _initLogger();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _logger.info("Firebase app is initialized");
  }

  static Future<FirebaseFirestore> getEmulatorInstance() async {
    await _initApp();

    final instance = FirebaseFirestore.instance;
    instance.useFirestoreEmulator('localhost', 8080);
    _logger.info("Firebase instance is configured "
        "to use emulator on localhost:8080");
    return instance;
  }

  static Future<FirebaseFirestore> getProductionInstance() async {
    await _initApp();
    return FirebaseFirestore.instance;
  }
}
