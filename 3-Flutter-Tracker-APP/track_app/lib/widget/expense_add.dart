import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_app/model/expense.dart';

class ExpenseAdd extends StatefulWidget {
  ExpenseAdd({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<ExpenseAdd> createState() {
    return _ExpenseAddState();
  }
}

class _ExpenseAddState extends State<ExpenseAdd> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.alimentari;

  _presentDataPicker() async {
    final date = DateTime.now();
    final firstData = DateTime(date.year - 1, date.month, date.day);
    final lastData = DateTime(date.year + 1, date.month, date.day);
    final dataScelta = await showDatePicker(
      context: context,
      firstDate: firstData,
      lastDate: lastData,
      initialDate: date,
    );
    setState(() {
      if (dataScelta != null) {
        _selectedDate = dataScelta;
      }
    });
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty ||
        _amountController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Errore'),
              content: const Text('Inserisci tutti i campi'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else {
      final name = _nameController.text;
      final amount = double.parse(_amountController.text);
      final date = _selectedDate!;
      final category = _selectedCategory;

      final newExpense = Expense(
        nome: name,
        spesa: amount,
        data: date,
        categoria: category,
      );

      widget.onAddExpense(newExpense);
      Navigator.of(context).pop(newExpense);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context)
                .viewInsets
                .bottom, // Sposta il contenuto quando la tastiera è aperta
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome spesa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Spesa',
                      prefixText: "€ ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _presentDataPicker,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _selectedDate == null
                                  ? 'Seleziona Data'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _presentDataPicker,
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<Category>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items:
                        Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                        ),
                        onPressed: _submit,
                        child: const Text(
                          'Aggiungi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Annulla',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
