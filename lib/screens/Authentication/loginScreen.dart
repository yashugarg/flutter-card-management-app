//login page for logging in
//parent file: main.dart/Onboarding.dart
// 23-12-2020 checked for new imp

import 'package:credit_card_project/services/auth.dart';
import 'package:credit_card_project/utils/RoutingUtils.dart';
import 'package:credit_card_project/utils/widgetExt.dart';
import 'package:credit_card_project/widgets/button.dart';
import 'package:credit_card_project/widgets/loadingDisabler.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

// this is the process of sign in through email and password
  Future<void> loginuser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await context
          .read<AuthService>()
          .login(
              username: emailController.text.trim(),
              password: passwordController.text)
          .catchError((e) {
        setState(() {
          isLoading = false;
        });
        WidgetHelper.showWarningDialog(context,
            title: "Login Failed", content: e.toString());
        return false;
      });
      setState(() {
        isLoading = false;
      });
      _navigate(res);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black12,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LoadingDisabler(
        isDisabled: isLoading,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_left),
                      color: Colors.black.withOpacity(0.3),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.signUp);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: TextFormField(
                  validator: (text) {
                    if (text!.contains("@")) {
                      return null;
                    } else if (!RegExp(
                      r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$",
                      caseSensitive: false,
                    ).hasMatch(text)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  controller: emailController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Icon(Icons.mail),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email ID',
                    labelText: 'Email ID',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  // ignore: missing_return
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Password cannot be empty ';
                    } else if (val.trim().length < 6) {
                      return 'Password should be of atleast 6 characters';
                    }
                  },
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: _toggle,
                        child: IntrinsicWidth(
                          child: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Password',
                    labelText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                  ),
                ),
              ),
              BigButton(
                  text: "LOG IN",
                  backgroundColor: Colors.blue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      loginuser();
                    }
                  }),
              const SizedBox(height: 32)
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(t) {
    if (t == true) {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.homepage, (route) => false);
    }
  }
}
