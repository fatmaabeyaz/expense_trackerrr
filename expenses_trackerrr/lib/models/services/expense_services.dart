import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Harcamaları Firestore'dan al
  Future<List<Expense>> getExpenses() async {
    final snapshot = await _firestore.collection('expenses').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Expense(
        id: doc.id,
        title: data['title'],
        amount: (data['amount'] as num).toDouble(),
        date: (data['date'] as Timestamp).toDate(),
        category: Category.values[data['category']],
      );
    }).toList();
  }

  // Harcama ekle
  Future<void> addExpense(Expense expense) async {
    await _firestore.collection('expenses').add({
      'title': expense.title,
      'amount': expense.amount,
      'date': expense.date,
      'category': expense.category.index,
    });
  }

  // Harcamayı güncelle
  Future<void> updateExpense(Expense expense) async {
    await _firestore.collection('expenses').doc(expense.id).update({
      'title': expense.title,
      'amount': expense.amount,
      'date': expense.date,
      'category': expense.category.index,
    });
  }

  // Harcamayı sil
  Future<void> deleteExpense(String id) async {
    await _firestore.collection('expenses').doc(id).delete();
  }
}
