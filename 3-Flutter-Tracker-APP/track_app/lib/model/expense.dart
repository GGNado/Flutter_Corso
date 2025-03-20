import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { alimentari, trasporti, work, abbigliamento }

class Expense {
  final String id;
  final String nome;
  final double spesa;
  final DateTime data;
  final Category categoria;

  Expense({
    required this.nome,
    required this.spesa,
    required this.data,
    required this.categoria,
  }) : id = uuid.v4();
}
