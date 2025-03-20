# Track App

Track App è un'applicazione Flutter per la gestione delle spese personali. Consente agli utenti di aggiungere, visualizzare e rimuovere le spese, categorizzandole in diverse categorie come alimentari, trasporti, lavoro e abbigliamento. L'app fornisce anche una visualizzazione grafica delle spese per categoria.

## Funzionalità principali

- **Aggiunta di spese**: Gli utenti possono aggiungere nuove spese specificando il nome, l'importo, la data e la categoria.
- **Visualizzazione delle spese**: Le spese vengono visualizzate in una lista, con la possibilità di rimuoverle tramite uno swipe.
- **Grafico delle spese**: Un grafico a barre mostra la distribuzione delle spese per categoria.

## Struttura del progetto

- `lib/main.dart`: Il punto di ingresso dell'applicazione. Configura il tema e avvia l'app.
- `lib/expenses.dart`: Contiene il widget principale `Expenses` che gestisce la lista delle spese e il grafico.
- `lib/model/expense.dart`: Definisce il modello `Expense` e l'enum `Category`.
- `lib/widget/expense_add.dart`: Contiene il widget `ExpenseAdd` per aggiungere nuove spese.
- `lib/widget/expense_list/expenses_list.dart`: Contiene il widget `ExpensesList` che visualizza la lista delle spese.
- `lib/widget/expense_list/expense_card.dart`: Contiene il widget `ExpenseCard` che rappresenta una singola spesa nella lista.
- `lib/widget/chart/chart.dart`: Contiene il widget `Chart` che visualizza il grafico delle spese.
- `lib/widget/chart/chart_bar.dart`: Contiene il widget `ChartBar` che rappresenta una singola barra nel grafico.

## Come funziona

### Aggiunta di spese

Il widget `ExpenseAdd` permette agli utenti di aggiungere nuove spese. Quando l'utente compila i campi e preme il pulsante "Aggiungi", viene creato un nuovo oggetto `Expense` e passato alla funzione `onAddExpense` definita nel widget `Expenses`.

```dart
void _submit() {
  final newExpense = Expense(
    nome: _nameController.text,
    spesa: double.parse(_amountController.text),
    data: _selectedDate!,
    categoria: _selectedCategory,
  );

  widget.onAddExpense(newExpense);
  Navigator.of(context).pop(newExpense);
}
```

### Visualizzazione delle spese

Le spese vengono visualizzate in una lista tramite il widget `ExpensesList`. Ogni spesa è rappresentata da un widget `ExpenseCard`. Gli utenti possono rimuovere una spesa effettuando uno swipe verso sinistra.

```dart
@override
Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: listaSpesa.length,
    itemBuilder: (ctx, index) => Dismissible(
      key: ValueKey(listaSpesa[index].id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onRemoveExpense(listaSpesa[index]);
      },
      child: ExpenseCard(expense: listaSpesa[index]),
    ),
  );
}
```

### Grafico delle spese

Il widget `Chart` visualizza un grafico a barre delle spese per categoria. Utilizza il widget `ChartBar` per rappresentare ogni barra del grafico.

```dart
@override
Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    width: double.infinity,
    height: 180,
    child: Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bucket in buckets)
                ChartBar(
                  fill: bucket.totalAmount == 0 ? 0 : bucket.totalAmount / maxTotalExpense,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: buckets.map((bucket) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                categoryIcons[bucket.category]!,
                color: isDarkMode ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ),
            ),
          )).toList(),
        ),
      ],
    ),
  );
}
```

## Come eseguire l'app

1. Clona il repository.
2. Installa le dipendenze con `flutter pub get`.
3. Esegui l'app con `flutter run`.

Buon divertimento con Track App!

