import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.onRemoveExpense,
    required this.expenses,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('expenses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final expenses = snapshot.data!.docs.map((document) {
          final data = document.data() as Map<String, dynamic>;
          return Expense(
            id: document.id,
            title: data['title'],
            amount: data['amount'],
            date: (data['date'] as Timestamp).toDate(),
            category: Expenses.getCategoryFromString(data['category']),
          );
        }).toList();

        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index]),
          ),
        );
      },
    );
  }
}