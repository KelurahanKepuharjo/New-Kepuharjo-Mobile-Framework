import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Wellcome/intropage1.dart';
import 'package:mobile_kepuharjo_new/Wellcome/intropage2.dart';
import 'package:mobile_kepuharjo_new/Wellcome/intropage3.dart';
import 'package:mobile_kepuharjo_new/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onLastPage = (value == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      "Skip",
                      style: MyFont.poppins(
                          fontSize: 13,
                          color: black,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: SlideEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: primaryColor),
                  ),
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: LoginPage(),
                                    type: PageTransitionType.fade));
                          },
                          child: Text(
                            "Done",
                            style: MyFont.poppins(
                                fontSize: 13,
                                color: black,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(
                            "Next",
                            style: MyFont.poppins(
                                fontSize: 13,
                                color: black,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                ],
              ))
        ],
      ),
    );
  }
}
