import 'package:first_app/central_text.dart';
import 'package:flutter/material.dart';

// Creazione Classe
// Estende quella classe che ci da diverse funzioni
class GradientConteiner extends StatelessWidget {
  // Tipo il costruttore di java?
  const GradientConteiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.green],
          // Ora faccio andare il colore dal top left al bottomRight
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), // In questo modo diamo un colore miscelato
      ),
      child: const Center(
        // `Center` è un widget che centra il suo figlio all'interno del contenitore padre.
        child: CentralTest(),
        // `Text` è un widget che mostra una stringa di testo.
        // In questo caso, visualizza "Ciao Mondo" al centro dello schermo.
      ),
    );
  }
}
