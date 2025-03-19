import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions_store.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/quiz_container.dart';
import 'package:quiz_app/risultati.dart';

class Questions extends StatefulWidget {
  const Questions({
    super.key,
    required this.selectAnswer,
    required this.getSelectedAnswer,
  });

  final void Function(String answer) selectAnswer;
  final List<String> Function() getSelectedAnswer;

  @override
  State<StatefulWidget> createState() {
    return _QuestionState();
  }
}

class _QuestionState extends State<Questions> {
  var currentQuestionIndex = 0;

  void changeQuestion(String answer) {
    widget.selectAnswer(answer);
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (ctx) => Risultati(listaAnswer: widget.getSelectedAnswer()),
          ), // Naviga alla schermata dei risultati
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentQuestion.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return ElevatedButton(
                onPressed: () {
                  changeQuestion(answer);
                },
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
