import 'package:flutter/material.dart';

class CentralTest extends StatelessWidget {
  const CentralTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "🌟 Ciao Mondo! 🌟",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.black26,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
