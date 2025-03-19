import 'package:flutter/material.dart';

class QuizContainer extends StatelessWidget {
  const QuizContainer({
    super.key,
    required this.buttonText,
    required this.centredText,
    required this.startQuiz,
  });
  final String buttonText;
  final String centredText;
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple, Colors.deepPurple],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: Image(
                image: AssetImage('assets/images/quiz-logo.png'),
                width: 250,
                color: const Color.fromARGB(150, 255, 255, 255),
              ),
            ),
            Text(
              centredText,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            OutlinedButton.icon(
              onPressed: startQuiz,
              icon: Icon(Icons.play_arrow),
              label: Text(buttonText),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ), // OutlinedButton.styleFrom
            ),
          ],
        ),
      ),
    );
  }
}
