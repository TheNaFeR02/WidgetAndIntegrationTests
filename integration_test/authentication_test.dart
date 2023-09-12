import 'package:f_testing_template/main.dart';
import 'package:f_testing_template/ui/pages/authentication/login.dart';
import 'package:f_testing_template/ui/pages/authentication/signup.dart';
import 'package:f_testing_template/ui/pages/content/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  Future<Widget> createHomeScreen() async {
    WidgetsFlutterBinding.ensureInitialized();
    return const MyApp();
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login sin creación de usuario", (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "123456"); //wrong password.

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets("Login -> signup -> creación usuario -> login no exitoso",
      (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
    await tester.pumpAndSettle();

    final signUpPage = find.byType(SignUpPage);
    expect(signUpPage, findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pumpAndSettle();

    final loginPage = find.byType(LoginScreen);
    expect(loginPage, findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "123456"); //wrong password.

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets("Login -> signup -> creación usuario -> login exitoso -> logout",
      (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
    await tester.pumpAndSettle();

    final signUpPage = find.byType(SignUpPage);
    expect(signUpPage, findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pumpAndSettle();

    final loginPage = find.byType(LoginScreen);
    expect(loginPage, findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "Uninorte1"); // Successful login.

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsWidgets); // We need to find 2 widgets
  });

  testWidgets(
      "Login -> signup -> creación usuario -> login éxitoso -> logout -> login exitoso",
      (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
    await tester.pumpAndSettle();

  
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpPage), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "Uninorte1"); // Successful login.

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget); 

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "Uninorte1"); // Successful login.

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets(
      "Login -> signup -> creación usuario -> login éxitoso -> logout -> login no exitoso",
      (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));
    await tester.pumpAndSettle();

  
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpPage), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "Uninorte1"); // Successful login.

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget); 

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(find.byKey(const Key('TextFormFieldLoginPassword')),
        "123456"); // Successful login.

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
