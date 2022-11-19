import 'package:classified_app/models/models.dart';
import 'package:classified_app/routes/route_generator.dart';
import 'package:classified_app/screens/edit_profile_screen.dart';
import 'package:classified_app/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('edit profile screen ...', (tester) async {
    // TODO: Implement test
    UserModel myUser = UserModel(
        email: 'demo@gmail.com',
        name: 'demo',
        mobile: '1212121212',
        imgURL: 'https://www.pngmart.com/files/2/Dragon-PNG-Photo.png');

    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      initialRoute: '/edit-profile',
      onGenerateRoute: RouteGenerator().routes,
      home: EditProfileScreen(
        myUser: myUser,
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('EditScaffold')), findsOneWidget);
  });
}
