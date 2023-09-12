// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:f_testing_template/ui/pages/authentication/login.dart';
import 'package:f_testing_template/ui/pages/authentication/signup.dart';
import 'package:f_testing_template/ui/pages/content/detail.dart';
import 'package:f_testing_template/ui/pages/content/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  testWidgets('Widget login validación @ email', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        key: Key("MaterialApp"),
        home: LoginScreen(
          key: Key("LoginScreen"),
          email: "fernandoacuna@uninorte.edu.co",
          password: "Uninorte1",
        )));

    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginEmail')), 'a.com');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), "Uninorte1");

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pump();

    expect(find.text("Enter valid email address"), findsOneWidget);
  });

  testWidgets('Widget login validación campo vacio email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        key: Key("MaterialApp"),
        home: LoginScreen(
          key: Key("LoginScreen"),
          email: "fernandoacuna@uninorte.edu.co",
          password: "Uninorte1",
        )));

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pump();

    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginEmail')), '');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), "Uninorte1");

    expect(find.text("Enter email"), findsOneWidget);
  });

  testWidgets('Widget login validación número de caracteres password',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        key: Key("MaterialApp"),
        home: LoginScreen(
          key: Key("LoginScreen"),
          email: "fernandoacuna@uninorte.edu.co",
          password: "Uninorte1",
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), "1234");

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pump();

    expect(find.text("Password should have at least 6 characters"),
        findsOneWidget);
  });

  testWidgets('Widget login validación campo vacio password',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        key: Key("MaterialApp"),
        home: LoginScreen(
          key: Key("LoginScreen"),
          email: "fernandoacuna@uninorte.edu.co",
          password: "Uninorte1",
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), '');

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pump();

    expect(find.text("Enter password"), findsOneWidget);
  });

  testWidgets('Widget login autenticación exitosa',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: LoginScreen(
          key: Key("LoginScreen"),
          email: "fernandoacuna@uninorte.edu.co",
          password: "Uninorte1",
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    final loginscreen = find.byKey(const Key("LoginScreen"));
    expect(loginscreen, findsNothing);
  });

  testWidgets('Widget login autenticación no exitosa',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        key: Key("MaterialApp"),
        home: LoginScreen(
          key: Key("LoginScreen"),
          email: "fernandoacuna@uninorte.edu.co",
          password: "Uninorte1",
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldLoginEmail')),
        '...@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pump();

    expect(find.byKey(const Key("LoginScreen")), findsOneWidget);
  });

  testWidgets('Widget signUp validación @ email', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: SignUpPage(
          key: Key("SignUpPage"),
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacunauninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pump();

    expect(find.text("Enter valid email address"), findsOneWidget);
  });

  testWidgets('Widget signUp validación campo vacio email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: SignUpPage(
          key: Key("SignUpPage"),
        )));

    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpEmail')), '');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), 'Uninorte1');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pump();

    expect(find.text("Enter email"), findsOneWidget);
  });

  testWidgets('Widget signUp validación número de caracteres password',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: SignUpPage(
          key: Key("SignUpPage"),
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), '1234');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pump();

    expect(find.text("Password should have at least 6 characters"),
        findsOneWidget);
  });

  testWidgets('Widget signUp validación campo vacio password',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: SignUpPage(
          key: Key("SignUpPage"),
        )));

    await tester.enterText(find.byKey(const Key('TextFormFieldSignUpEmail')),
        'fernandoacuna@uninorte.edu.co');
    await tester.enterText(
        find.byKey(const Key('TextFormFieldSignUpPassword')), '');

    await tester.tap(find.byKey(const Key('ButtonSignUpSubmit')));
    await tester.pump();

    expect(find.text("Enter password"), findsOneWidget);
  });

  testWidgets('Widget home visualización correo', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: HomePage(
          key: Key("HomePage"),
          loggedEmail: "fernandoacuna@uninorte.edu.co",
          loggedPassword: "Uninorte1",
        )));

    expect(find.text("Hello fernandoacuna@uninorte.edu.co"), findsOneWidget);
  });

  testWidgets('Widget home nevegación detalle', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: HomePage(
          key: Key("HomePage"),
          loggedEmail: "fernandoacuna@uninorte.edu.co",
          loggedPassword: "Uninorte1",
        )));

    await tester.tap(find.byKey(const Key('ButtonHomeDetail')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("HomePage")), findsNothing);
  });

  testWidgets('Widget home logout', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
        key: Key("MaterialApp"),
        home: HomePage(
          key: Key("HomePage"),
          loggedEmail: "fernandoacuna@uninorte.edu.co",
          loggedPassword: "Uninorte1",
        )));

    await tester.tap(find.byKey(const Key('ButtonHomeLogOff')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("HomePage")), findsNothing);
  });
}
