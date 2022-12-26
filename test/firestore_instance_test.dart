import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_figure_saver/firestore_instance.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  test(
      "Assert emulator is used when parameter"
      "'useEmulator' is set to true", () {
    final mockFirestore = MockFirestore();
    FirestoreInstance(instance: mockFirestore, useEmulator: true);
    verify(() => mockFirestore.useFirestoreEmulator(any(), any())).called(1);
  });
  test("Assert emulator is not used when 'useEmulator' is set to false", () {
    final mockFirestore = MockFirestore();
    FirestoreInstance(instance: mockFirestore, useEmulator: false);
    verifyNever(() => mockFirestore.useFirestoreEmulator(any(), any()));
  });

  test("Assert getInstance return the firestore instance", () {
    final mockFirestore = MockFirestore();
    final firestore = FirestoreInstance(instance: mockFirestore);
    expect(firestore.getInstance, equals(mockFirestore));
  });
}
