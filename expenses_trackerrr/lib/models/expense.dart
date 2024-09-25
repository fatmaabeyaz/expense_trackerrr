// kind of structure expense would have.
// data model of expense kinda blue print.
// tp generate unique id dynamically we use uuid package.
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
  other
} //creates custom types which is a combination of predefined values.

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
}; // icon that belong to multiple files.

class Expense {
  Expense({
    String? id, // Make the 'id' parameter optional
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = id ??
            uuid.v4(); //initalizer list after clsong parenthesis. v4 method to generate unique id.

  final String? id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //use Category as custom type here.

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  //for creating chart for each category.

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); // go to all the categories and filter out the one of particualr category.

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    //utility getter which sums up all the expenses.
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}