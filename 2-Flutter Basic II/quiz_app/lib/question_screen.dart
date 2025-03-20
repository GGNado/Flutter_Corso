import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  final String question;
  final List<String> answers;
  final VoidCallback changeQuestion;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.answers,
    required this.changeQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question),
        ...answers
            .map(
              (answer) => ElevatedButton(
                onPressed: changeQuestion,
                child: Text(answer),
              ),
            )
            .toList(),
      ],
    );
  }
}
