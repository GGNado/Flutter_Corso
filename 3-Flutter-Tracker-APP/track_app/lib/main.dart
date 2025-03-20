import 'package:flutter/material.dart';
import 'package:track_app/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(centerTitle: true),
      ),
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    ),
  );
}
