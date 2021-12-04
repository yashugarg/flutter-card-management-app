import 'package:credit_card_project/screens/Authentication/loginScreen.dart';
import 'package:credit_card_project/screens/Authentication/signupScreen.dart';
import 'package:credit_card_project/screens/allCards.dart';
import 'package:credit_card_project/screens/newCard.dart';
import 'package:credit_card_project/utils/RoutingUtils.dart';
import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/*
    Adding route to router
 * Step 1: Add your route as a member in Routes class of lib/utils/RoutingUtils.dart
   if your route takes an argument mention it above the member as a doc comment
 *Step 2: Add case to this files
    you can just copy this code and paste it above "Paste code above this comment"

    case Routes.yourRouteName:
    return MaterialPageRoute(builder: (_) {
    //run type checks if you want to on arguements
    return YourWidget();
    });
    You can run type checks and return any wigdet you want but don't forget to return some wiget at the end
*/

class Router {
  Router._();

  static Widget wrong =
      const Scaffold(body: Center(child: Text('Something went wrong')));

  static MaterialPageRoute routify(Widget screen, {RouteSettings? settings}) =>
      MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(body: screen),
      );

  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        //auth
        case Routes.login:
          return routify(LoginPage());
        case Routes.signUp:
          return routify(SignupPage());
        //home
        case Routes.homepage:
          return routify(HomePage());
        case Routes.newCard:
          return routify(NewCard());

        //user
        // case Routes.userInfo:
        //   return routify(Profile());

        // case Routes.editProfile:
        //   return routify(EditUserProfile());

        default:
          return routify(
            Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
      }
    } catch (e) {
      return routify(wrong);
    }
  }
}
