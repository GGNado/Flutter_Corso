import 'package:flutter/material.dart'; // Importa il pacchetto Flutter Material, che contiene widget predefiniti per UI moderna
import 'package:first_app/gradient_conteiner.dart';

// Le applicazioni Flutter sono basate su una struttura ad albero di widget.
// Ogni elemento dell'interfaccia utente è un widget, che può essere nidificato all'interno di altri widget.
// Per saperne di più sui widget, visita la documentazione ufficiale: https://docs.flutter.dev/ui/widgets

void main() {
  // Il metodo `main()` è il punto di ingresso dell'app Flutter.

  // Il metodo `runApp()` avvia l'app Flutter e prende un widget come argomento.
  // In questo caso, l'app è costruita utilizzando `MaterialApp`, che è il widget principale
  // usato per le app basate sul Material Design.

  runApp(
    const MaterialApp(
      // `MaterialApp` è il widget di base per le app Flutter che usano il Material Design.
      // Definiamo qui la struttura e il comportamento generale dell'app.
      home: Scaffold(
        // `Scaffold` è un widget che fornisce la struttura di base per la UI,
        // come AppBar, FloatingActionButton, Drawer, etc.
        //backgroundColor: Colors.pink, solo un colore
        body: GradientConteiner(),
      ),
    ),
  ); // Fine di `runApp()`

  // 🔥 Nota sull'uso di `const`:
  // Il `const` davanti a `MaterialApp` aiuta a ottimizzare le prestazioni.
  // Indica a Flutter che questo widget e i suoi sotto-widget non cambieranno mai,
  // quindi possono essere riutilizzati senza bisogno di essere ridisegnati in memoria.
}
