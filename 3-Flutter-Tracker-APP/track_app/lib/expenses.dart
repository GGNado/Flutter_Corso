import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

final List<Expense> _listaSpeseOLD = [
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
  List<Expense> _listaSpese = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Category fromString(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'alimentari':
        return Category.alimentari;
      case 'trasporti':
        return Category.trasporti;
      case 'work':
        return Category.work;
      case 'abbigliamento':
        return Category.abbigliamento;
      default:
        throw ArgumentError('Categoria non valida: $categoria');
    }
  }

  Future<void> _fetchExpenses() async {
    final url = Uri.parse('http://localhost:8080/api/expenses');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      setState(() {
        _listaSpese =
            decoded
                .map(
                  (e) => Expense(
                    nome: e['nome'],
                    spesa: e['spesa'],
                    data: DateTime.parse(e['data']),
                    categoria: fromString(e['categoria']),
                  ),
                )
                .toList();
      });
    } else {
      // gestisci errore
    }
  }

  Future<void> _removeFetchExpense(Expense expense) async {
    String nome = expense.nome;
    String data = expense.data.toString();
    final url = Uri.parse(
      'http://localhost:8080/api/expenses/nome/${nome}/data/${data}',
    ); // cambia passando l'intero expense

    _listaSpese.remove(expense);
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      // gestisci errore
      _listaSpese.add(copyExpense(expense));
    }
  }

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
      //_listaSpese.remove(expense);
      _removeFetchExpense(expense);
    });
  }

  Expense copyExpense(Expense expense) {
    return Expense(
      nome: expense.nome,
      spesa: expense.spesa,
      data: expense.data,
      categoria: expense.categoria,
    );
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
