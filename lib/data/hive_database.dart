import 'package:hive/hive.dart';

import '../models/expense_item.dart';

class HiveDataBase {

  final _mybox = Hive.box('expense_database');

  // write data to hive box

  void saveData( List<ExpenseItem> allExpense){

    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.title,
        expense.amount,
        expense.date,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

    _mybox.put('ALL_EXPENSES', allExpenseFormatted);

  }

  // read data from hive box

  List<ExpenseItem> readData(){
    
    List savedExpense = _mybox.get('ALL_EXPENSES') ?? [];
    List<ExpenseItem> allExpense = [];

    for ( int i = 0; i < savedExpense.length; i++) {
      String title = savedExpense[i][0];
      double amount = savedExpense[i][1];
      DateTime date = savedExpense[i][2];

      ExpenseItem expense = ExpenseItem(
        title: title,
        amount: amount,
        date: date,
      ); 

      allExpense.add(expense);
    }

    return allExpense;
  }

}