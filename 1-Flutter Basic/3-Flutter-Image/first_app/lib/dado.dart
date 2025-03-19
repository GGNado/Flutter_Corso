import 'package:flutter/material.dart';

class Dado extends StatefulWidget {
  Dado({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DadoState();
  }
}

class _DadoState extends State<Dado> {
  var dadoAttivo = "3";

  void rollDice() {
    setState(() {
      // qui tutte le modifiche runtime
      dadoAttivo =
          (1 + (new DateTime.now().millisecondsSinceEpoch % 6)).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/img/dice-$dadoAttivo.png", width: 200),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(10),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 30),
          ),
          child: Text("Lancia il dato!"),
        ),
      ],
    );
  }
}
