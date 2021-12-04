// 23-12-2020 checked for new imp

import 'package:credit_card_project/services/auth.dart';
import 'package:credit_card_project/utils/RoutingUtils.dart';
import 'package:credit_card_project/utils/widgetExt.dart';
import 'package:credit_card_project/widgets/button.dart';
import 'package:credit_card_project/widgets/loadingDisabler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool triedSignUpOnce = false;
  bool _obscurePassword = true;
  bool _obscureRePassword = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController displayController = TextEditingController();
  // bool age = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _register() async {
    if (passwordController.text == repasswordController.text) {
      if (_formKey.currentState!.validate()) {
        try {
          setState(() {
            isLoading = true;
            triedSignUpOnce = true;
          });
          final bool resp = await context.read<AuthService>().signup(
              displayName: displayController.text,
              email: emailController.text.trim(),
              password: passwordController.text);
          if (!resp) {
            setState(() {
              isLoading = false;
            });
            throw "Failed to signup";
          } else {
            //show success
            setState(() {
              isLoading = false;
            });
            Navigator.popUntil(context, (route) => false);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.homepage, (route) => false);
          }
        } catch (e) {
          WidgetHelper.showWarningDialog(context,
              title: "Couldn't Sign you up", content: '$e');
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else if (passwordController.text.length < 6 ||
        repasswordController.text.length < 6) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(const SnackBar(
          content: Text('Password should be at least 6 character long')));
    } else {
      _scaffoldKey.currentState!.showSnackBar(const SnackBar(
          content: Text('Confirm password and password do not match')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backwardsCompatibility: false,
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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 64),
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
                            }),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
                          },
                          child: Text(
                            "Log In",
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
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Full Name can't be empty" : null,
                      controller: displayController,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: InputDecoration(
                        fillColor: const Color(0xFFF3F3F3),
                        filled: true,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: Icon(Icons.person),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Name',
                        labelText: 'Name',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 24.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
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
                      decoration: InputDecoration(
                        fillColor: const Color(0xFFF3F3F3),
                        filled: true,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: Icon(Icons.mail),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Email ID',
                        labelText: 'Email ID',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 24.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Password',
                        labelText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 24.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextFormField(
                      controller: repasswordController,
                      obscureText: _obscureRePassword,
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
                            onTap: _toggleRe,
                            child: IntrinsicWidth(
                              child: Icon(_obscureRePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 24.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BigButton(
                    text: "SIGN UP",
                    backgroundColor: Colors.blue,
                    onTap: _register,
                    vertialPadding: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // Toggles the re-enter password show status
  void _toggleRe() {
    setState(() {
      _obscureRePassword = !_obscureRePassword;
    });
  }
}
