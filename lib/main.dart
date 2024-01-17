import 'package:flutter/material.dart';
import 'package:flutter_faker/pages/home.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: introductionPage(),
    );
  }
}

class introductionPage extends StatelessWidget {
  const introductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Title of introduction page 1",
          body: "Welcome to the app! This is a description of how it works.",
          image: Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Lottie.asset("assets/images/satu.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Title of introduction page 2",
          body: "Welcome to the app! This is a description of how it works.",
          image: Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Lottie.asset("assets/images/dua.json"),
            ),
          ),
        )
      ],
      showNextButton: true,
      next: const Text("Next"),
      done: const Text("Done"),
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ),
        );
      },
    );
  }
}
