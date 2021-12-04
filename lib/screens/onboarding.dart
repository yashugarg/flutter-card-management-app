import 'package:credit_card_project/utils/RoutingUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  List<Map<dynamic, dynamic>> onboardingData = [
    {
      'text1': 'Create A Card',
      'text2': 'Create your own card based on your preference',
      "image": "assets/images/card1.png",
      "height": 322.0
    },
    {
      "text1": 'Own Many Cards',
      "text2": 'Add as many cards to your digital wallet',
      "image": "assets/images/card2.png",
      "height": 322.0
    },
    {
      "text1": 'Get Instant Notification',
      "text2": 'Instant notification about any transaction',
      "image": "assets/images/card3.png",
      "height": 322.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.white),
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 468,
                    child: PageView.builder(
                      itemCount: onboardingData.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          onboardingData[currentPage]['image'],
                          height: (onboardingData[currentPage]['height']),
                          width: double.infinity,
                        ),
                      ),
                      onPageChanged: (value) => {
                        setState(() => {
                              currentPage = value,
                            })
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 847 * 379,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.0),
                          topLeft: Radius.circular(50.0),
                        ),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.only(top: 25.0),
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) => buildDot(index),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: PageView.builder(
                              itemCount: onboardingData.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  onboardingData[currentPage]["text1"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onPageChanged: (value) => {
                                setState(() => {
                                      currentPage = value,
                                    })
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: PageView.builder(
                              itemCount: onboardingData.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  onboardingData[currentPage]["text2"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onPageChanged: (value) => {
                                setState(() => {
                                      currentPage = value,
                                    })
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(bottom: 5, right: 12),
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                child: Text(
                                  currentPage == (onboardingData.length - 1)
                                      ? "NEXT"
                                      : "SKIP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  textAlign: TextAlign.end,
                                ),
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, Routes.login),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 379,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 30 : 6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
