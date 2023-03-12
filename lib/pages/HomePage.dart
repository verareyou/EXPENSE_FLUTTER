import 'package:first_app/components/expense_summary.dart';
import 'package:first_app/components/expense_tile.dart';
import 'package:first_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // addNewExpense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('Add New Expense'),
        contentPadding: EdgeInsets.all(0),
        // contentTextStyle: TextStyle(color: Colors.white),
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Expense',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(children: [
                TextField(
                  controller: newExpenseNameController,
                  decoration: InputDecoration(
                    labelText: 'Expense Name',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                    // style
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextField(
                  controller: newExpenseAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Expense Amount',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                    // style
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
        // actions position
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          // button size
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // width: 100,
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                child: MaterialButton(
                  onPressed: save,
                  child: Icon(Icons.savings,
                      color: Color.fromARGB(255, 111, 209, 62)),
                  // design
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 50,
                child: MaterialButton(
                  onPressed: cancel,
                  child:
                      Icon(Icons.cancel, color: Color.fromARGB(255, 255, 0, 0)),
                  // design
                  color: Color.fromARGB(255, 255, 255, 255),
                  textColor: Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          )
        ],
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
    );
  }
  //delete
  
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  } 

  // save
  void save() {
    if(newExpenseNameController.text.isEmpty || newExpenseAmountController.text.isEmpty) {
      return;
    }
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(
      ExpenseItem(
          title: newExpenseNameController.text,
          amount: double.parse(newExpenseAmountController.text),
          date: DateTime.now()),
    );

    // clear text field
    newExpenseNameController.clear();
    newExpenseAmountController.clear();

    Navigator.pop(context);
  }

  // cancel
  void cancel() {
    print('cancel');

    // clear text field
    newExpenseNameController.clear();
    newExpenseAmountController.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 236, 233),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: TextButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add, color: Color.fromARGB(255, 255, 255, 255)),
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
          ),
        ),
        body: ListView(
          children: [
            // header
            Container(
              padding:
                  EdgeInsets.only(top: 40, bottom: 30, left: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expense Tracker',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Today: ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 146, 146, 146),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${value.getExpenseForDay(DateTime.now()).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 146, 146, 146),
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Week Total:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 146, 146, 146),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' \$${value.getExpenseForWeek(DateTime.now()).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 146, 146, 146),
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // bar graph
            ExpenseSummary(
              startOfWeek: value.startOfWeekDate(),
            ),
            // expense list
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.overallExpenseList.length,
              itemBuilder: (context, index) => ExpenseTile(
                  index: index,
                  title: value.overallExpenseList[index].title,
                  date: value.overallExpenseList[index].date,
                  amount: value.overallExpenseList[index].amount.toString(),
                  deletedTapped: (p0) => {
                    deleteExpense(value.getAllExpenses()[index])
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
