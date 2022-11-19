import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('edit profile appbar ...', (tester) async {
    // TODO: Implement test
    expect(find.byKey(const Key('EditAppbar')), findsOneWidget);
  });
}
