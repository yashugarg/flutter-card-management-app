// *using router :
//  *  ```
//  Navigator.pushNamed(Routes.routeName)
//  * ```
//  *
// *passing arguments, routes that require arguments recieve it through a map (occassionally Strings )
//  *
//  * the structure of map for arguments for certain
// *  routes is present as a documentation comment
// *  ```
//  Navigator.pushNamed(Routes.routeName, arguments: {"key1":val1,"key2":val2})
//  * ```
// * you can hover a route it anywhere in VSCode/Android Studio to see argement structure
class Routes {
  //auth
  static const String forgotPwd = 'forgetPassword';
  static const String login = 'login';
  static const String signUp = 'SignUp';
  //home
  static const String homepage = 'homepage';
  static const String newCard = 'newCard';
  //user
  static const String userInfo = 'userInfo';
  static const String editProfile = 'editProfile';

  static const List<String> unprotectedRouts = [login, signUp, forgotPwd];
}
