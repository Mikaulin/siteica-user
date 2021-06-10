import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:siteica_user/app/welcome_slides.dart';
import 'package:siteica_user/ui/register.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Slide> slides = welcomeSlides;

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      renderSkipBtn: renderSkipBtn(),
      colorSkipBtn: Color(0x33000000),
      highlightColorSkipBtn: Color(0xff000000),
      renderNextBtn: renderNextBtn(),
      renderDoneBtn: renderDoneBtn(),
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),
      colorDot: Color(0x336C63FF),
      colorActiveDot: Color(0xff6C63FF),
      sizeDot: 13.0,
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
    );
  }
}