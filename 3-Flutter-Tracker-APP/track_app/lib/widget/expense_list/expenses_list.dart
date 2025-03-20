import 'package:flutter/material.dart';
import 'package:track_app/model/expense.dart';
import 'package:track_app/widget/expense_list/expense_card.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.listaSpesa,
    required this.onRemoveExpense,
  });

  final List<Expense> listaSpesa;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaSpesa.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            key: ValueKey(
              listaSpesa[index].id,
            ), // Usa un valore unico per la chiave
            direction:
                DismissDirection
                    .endToStart, // Permette solo lo swipe da destra a sinistra
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              debugPrint("Spesa rimossa: ${listaSpesa[index].nome}");
              onRemoveExpense(listaSpesa[index]);
            },
            child: ExpenseCard(expense: listaSpesa[index]),
          ),
    );
  }
}
