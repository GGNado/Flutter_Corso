import 'package:flutter/material.dart';
import 'package:track_app/model/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  ExpenseCard({
    required this.expense,
    //required Null Function(dynamic direction) onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        title: Text(
          expense.nome,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "€ ${expense.spesa.toStringAsFixed(2)} - ${expense.data.day}/${expense.data.month}/${expense.data.year}",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: _getCategoryColor(expense.categoria),
          child: Icon(_getCategoryIcon(expense.categoria), color: Colors.white),
        ),
      ),
    );
  }

  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.alimentari:
        return Colors.green;
      case Category.trasporti:
        return Colors.blue;
      case Category.work:
        return Colors.orange;
      case Category.abbigliamento:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.alimentari:
        return Icons.fastfood;
      case Category.trasporti:
        return Icons.directions_car;
      case Category.work:
        return Icons.work;
      case Category.abbigliamento:
        return Icons.shopping_bag;
      default:
        return Icons.category;
    }
  }
}
