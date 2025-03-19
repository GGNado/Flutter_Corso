import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/data/questions_store.dart'; // Assumendo che le domande siano definite qui

class Risultati extends StatelessWidget {
  Risultati({super.key, required this.listaAnswer});

  final List<String> listaAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 100), // Aggiunge spazio sopra il titolo
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Hai risposto alle ${listaAnswer.length} domande",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20), // Spazio tra il titolo e la lista
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(
                  maxHeight: 300,
                ), // Limita l'altezza della lista
                child: ListView.builder(
                  itemCount: listaAnswer.length,
                  itemBuilder: (context, index) {
                    bool isCorrect =
                        listaAnswer[index] == questions[index].answers.first;
                    return Card(
                      color:
                          isCorrect
                              ? Colors.green.withOpacity(0.8)
                              : Colors.red.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Domanda ${index + 1}: ${listaAnswer[index]}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
