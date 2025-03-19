import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/quiz_container.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswer = [];
  String activeScreen = "start-screen";

  void switchScreen() {
    setState(() {
      activeScreen = "quiz-1-screen";
    });
  }

  void selectAnswer(String answer) {
    setState(() {
      print(answer);
      selectedAnswer.add(answer);
    });
  }

  List<String> get getSelectedAnswer {
    return selectedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:
            activeScreen == "start-screen"
                ? QuizContainer(
                  buttonText: "Premi per Iniziare",
                  centredText: "Benvenuto al Flutter Quiz!",
                  startQuiz: switchScreen,
                )
                : Questions(
                  selectAnswer: selectAnswer,
                  getSelectedAnswer: () {
                    return selectedAnswer;
                  },
                ),
      ),
    );
  }
}
