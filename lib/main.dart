import 'dart:io';
import 'package:credit_card_project/screens/allCards.dart';
import 'package:credit_card_project/screens/onboarding.dart';
import 'package:credit_card_project/services/auth.dart';
import 'package:credit_card_project/utils/router.dart' as router;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      builder: (context, snapshot) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards Project',
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.Router.generateRoute,
      home: Builder(
        builder: (context) {
          context.watch<AuthService>().status;
          switch (context.watch<AuthService>().status) {
            case LoginStatus.idle:
              return OnboardingScreen();
            case LoginStatus.loggedIn:
              return HomePage();
            case LoginStatus.loading:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              return OnboardingScreen();
          }
        },
      ),
    );
  }
}
