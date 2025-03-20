import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:track_app/widget/chart/chart.dart';
import 'package:track_app/widget/expense_add.dart';
import 'package:track_app/widget/expense_list/expenses_list.dart';
import 'package:track_app/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

final List<Expense> _listaSpese = [
  Expense(
    nome: "Pizza",
    spesa: 10.00,
    data: DateTime.now(),
    categoria: Category.alimentari,
  ),
  Expense(
    nome: "Benzina",
    spesa: 50.00,
    data: DateTime.now(),
    categoria: Category.trasporti,
  ),
  Expense(
    nome: "Scarpe",
    spesa: 100.00,
    data: DateTime.now(),
    categoria: Category.abbigliamento,
  ),
];

class _ExpensesState extends State<Expenses> {
  void _openAddExpense() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return ExpenseAdd(onAddExpense: _addExpense);
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _listaSpese.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      print("aaa");
      _listaSpese.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track App'),
        actions: [
          IconButton(onPressed: _openAddExpense, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chart(expenses: _listaSpese),
          //Text("Da rimpiazzare con Lista spese"),
          // Creo un nuovo Widget per la lista delle spese
          Expanded(
            child: ExpensesList(
              listaSpesa: _listaSpese,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
    : expenses =
          allExpense.where((expense) => expense.categoria == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalAmount {
    double total = 0;
    for (final expense in this.expenses) {
      if (expense.categoria == category) {
        total += expense.spesa;
      }
    }

    return total;
  }
}
