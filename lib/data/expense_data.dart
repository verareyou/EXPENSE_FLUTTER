import 'package:first_app/datetime/date_time_helper.dart';
import 'package:first_app/models/expense_item.dart';
import 'package:flutter/cupertino.dart';

import 'hive_database.dart';

class ExpenseData extends ChangeNotifier {
  // list of all  expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list

  List<ExpenseItem> getAllExpenses() {
    return overallExpenseList;
  }


  final db = HiveDataBase();
  void prepareData(){
    if(db.readData().isNotEmpty){
      overallExpenseList = db.readData();
    }
  }

  // add new expense

  void addNewExpense(ExpenseItem expense) {
    overallExpenseList.add(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday from date

  String getWeekday(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "Mon";
    }
  }

  // get month from date

  String getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "Jan";
    }
  }

  // get total expense

  double getTotalExpense() {
    double total = 0;
    for (var i = 0; i < overallExpenseList.length; i++) {
      total += overallExpenseList[i].amount;
    }
    return total;
  }

  // get total expense for a particular week

  double getExpenseForWeek(DateTime date) {
    double total = 0;
    for (var i = 0; i < overallExpenseList.length; i++) {
      if (overallExpenseList[i].date.isAfter(date.subtract(Duration(days: 7))) &&
          overallExpenseList[i].date.isBefore(date)) {
        total += overallExpenseList[i].amount;
      }
    }
    return total;
  }

  // get total expense for a particular day

  double getExpenseForDay(DateTime date) {
    double total = 0;
    for (var i = 0; i < overallExpenseList.length; i++) {
      if (overallExpenseList[i].date.day == date.day &&
          overallExpenseList[i].date.month == date.month &&
          overallExpenseList[i].date.year == date.year) {
        total += overallExpenseList[i].amount;
      }
    }
    return total;
  }

  // get the date for the start of the week

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get the current date
    DateTime currentDate = DateTime.now();

    // go back to the start of the week
    for(int i = 0; i < 7; i++){
      if(getWeekday(currentDate.subtract(Duration(days: i))) == "Sun"){
        startOfWeek = currentDate.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  // get expense by the day

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateToString(expense.date);
      double amount = expense.amount;

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }

    }

    return dailyExpenseSummary;
  }

}