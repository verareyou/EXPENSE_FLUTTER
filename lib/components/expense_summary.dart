import 'package:first_app/barGraph/bar_graph.dart';
import 'package:first_app/data/expense_data.dart';
import 'package:first_app/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMaxY(ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    values.sort();

    return values.last < 1000 ? 1000 : values.last * 1.1;

  }

  @override
  Widget build(BuildContext context) {

    String sunday = convertDateToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: calculateMaxY(value,
          sunday,
          monday,
          tuesday,
          wednesday,
          thursday,
          friday,
          saturday
          ),
          sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
          monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
          tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
          wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
          thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
          friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
          satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
